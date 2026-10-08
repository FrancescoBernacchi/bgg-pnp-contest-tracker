const {test}=require('node:test'),assert=require('node:assert/strict'),vm=require('node:vm'),fs=require('node:fs');
const context=vm.createContext({console,URL,document:{querySelector:()=>({}),querySelectorAll:()=>[]},window:{addEventListener:()=>{}},fetch:()=>new Promise(()=>{})});
vm.runInContext(fs.readFileSync(__dirname+'/static/app.js','utf8'),context);
vm.runInContext(fs.readFileSync(__dirname+'/static/source-records.js','utf8'),context);
const run=s=>vm.runInContext(s,context);
test('Source search combines typed fields and preserves source-only / candidate states',()=>{
 run(`data={source_records:[{id:1,source_key:'pergioco',titles:['Omonimo 1975'],aliases:['Alias'],classifications:[{label_raw:'Famiglia',kind_raw:'breadcrumb',segments:[]}],credits:[{name_raw:'Persona',role_raw:'designer'}],admissions:[{outcome_normalized:'requirement_not_demonstrated'}],matches:[]},{id:2,source_key:'pergioco',titles:['Omonimo 2001'],aliases:[],classifications:[],credits:[],admissions:[{outcome_normalized:'admitted'}],matches:[{game_id:9,match_status:'candidate'}]}]};`);
 assert.equal(run(`matchingRecords('pergioco').length`),2);
 run(`Object.assign(recordFilters,{query:'Persona',field:'credits',admission:'requirement_not_demonstrated',matching:'source_only'});`);
 assert.equal(run(`matchingRecords('pergioco')[0].id`),1);
 run(`recordFilters.field='titles'`);assert.equal(run(`matchingRecords('pergioco').length`),0);
 run(`Object.assign(recordFilters,{query:'',field:'all',admission:'',matching:'candidate'});`);assert.equal(run(`matchingRecords('pergioco')[0].id`),2);
});
test('Unknown cost is not zero; external schemes and credentials are inert',()=>{
 assert.equal(run('yesNo(null)'),'Ignoto');assert.equal(run('yesNo(0)'),'No');
 for(const url of ['javascript:alert(1)','https://u:p@example.test','data:text/html,hi'])assert.doesNotMatch(run(`externalLink(${JSON.stringify(url)},'<unsafe>')`),/<a /);
 assert.match(run(`externalLink('https://example.test','<unsafe>')`),/&lt;unsafe&gt;/);
});
test('Native segment K is distinct from I-K and label substrings',()=>{
 assert.equal(run(`classificationValues({label_raw:'Krypte',segment_raw:'I-K',index_title_raw:null,segments:[]}).includes('K')`),false);
 assert.equal(run(`classificationValues({label_raw:'Krypte',segment_raw:'I-K',index_title_raw:null,segments:[{label_raw:'K'}]}).includes('K')`),true);
});
