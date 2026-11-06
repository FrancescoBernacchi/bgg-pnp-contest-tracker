"""Read-only current projection of verified catalog duplicates; main history is untouched."""
import re

def duplicate_map(db):
    tables={r[0] for r in db.execute("SELECT name FROM main.sqlite_master WHERE type='table'")}
    if 'game_relationships' not in tables:return {}
    pairs=list(db.execute("SELECT from_game_id,to_game_id FROM main.game_relationships WHERE relationship_type='duplicate_of' AND verification_status='verified'"))
    result={}
    for source,target in pairs:
        if source in result and result[source]!=target:raise ValueError('Conflicting duplicate targets')
        result[source]=target
    for source in result:
        seen=set();current=source
        while current in result:
            if current in seen:raise ValueError('Duplicate cycle')
            seen.add(current);current=result[current]
        if not db.execute('SELECT 1 FROM main.games WHERE id=?',(current,)).fetchone():raise ValueError('Missing canonical target')
    return result

def canonical_game_id(db,game_id):
    mapping=duplicate_map(db)
    while game_id in mapping:game_id=mapping[game_id]
    return game_id

def retired_entry_ids(db):
    mapping=duplicate_map(db)
    return {r[0] for r in db.execute('SELECT id,game_id FROM main.entries') if r[1] in mapping}

def canonical_entry_id(db,entry_id):
    row=db.execute('SELECT contest_id,game_id FROM main.entries WHERE id=?',(entry_id,)).fetchone()
    if not row:return entry_id
    target=canonical_game_id(db,row[1])
    if target==row[1]:return entry_id
    active=db.execute('SELECT id FROM main.entries WHERE contest_id=? AND game_id=?',(row[0],target)).fetchone()
    return active[0] if active else entry_id

def install_current_projection(db):
    mapping=duplicate_map(db)
    if not mapping:return
    if db.execute("SELECT 1 FROM temp.sqlite_master WHERE type='view' AND name='games'").fetchone():return
    # TEMP views only; install before PRAGMA query_only. No persistent schema/data write.
    db.execute("CREATE TEMP VIEW games AS SELECT * FROM main.games WHERE id NOT IN (SELECT from_game_id FROM main.game_relationships WHERE relationship_type='duplicate_of' AND verification_status='verified')")
    db.execute('CREATE TEMP VIEW entries AS SELECT * FROM main.entries WHERE game_id IN (SELECT id FROM temp.games)')
    for name in ['v_entries_standalone','v_entries_dependent_variants','v_contests_monitoring_all','v_contests_pnp_core','v_contests_adjacent']:
        row=db.execute("SELECT sql FROM main.sqlite_master WHERE type='view' AND name=?",(name,)).fetchone()
        if row:db.execute(re.sub(r'^CREATE\s+VIEW\s+', 'CREATE TEMP VIEW ', row[0],count=1,flags=re.I))
