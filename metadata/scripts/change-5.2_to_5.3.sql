alter table bpm_solution add act_def_id_  varchar(64);
alter table bpm_node_set add act_def_id_  varchar(64);
alter table bpm_sol_fv add act_def_id_ varchar(64);
alter table bpm_sol_var add act_def_id_ varchar(64);
alter table bpm_sol_user add act_def_id_ varchar(64);
alter table BPM_SOL_USERGROUP add act_def_id_ varchar(64);
alter table BPM_TEST_SOL add act_def_id_ varchar(64);
alter table bpm_fv_right add act_def_id_ varchar(64);
alter table bpm_test_case add act_def_id_ varchar(64);

-- zyg 2017-04-05  手机表单和bo进行绑定。	
ALTER TABLE `bpm_mobile_form` DROP COLUMN `VIEW_ID_`;
ALTER TABLE `bpm_mobile_form`  ADD COLUMN `BO_DEF_ID_`  varchar(255) NULL COMMENT 'BO定义ID' ;

update BPM_SOLUTION bs SET bs.ACT_DEF_ID_=(select  are.ID_ from ACT_RE_PROCDEF are  where bs.DEF_KEY_=are.KEY_ and are.VERSION_=(select "MAX"(b.version_) FROM ACT_RE_PROCDEF b where  bs.DEF_KEY_=b.KEY_));

update BPM_NODE_SET bns SET bns.ACT_DEF_ID_=(select BS.ACT_DEF_ID_ from BPM_SOLUTION bs where BS.SOL_ID_=bns.sol_id_);

update BPM_SOL_FV bnf SET bnf.ACT_DEF_ID_=(select BS.ACT_DEF_ID_ from BPM_SOLUTION bs where BS.SOL_ID_=bnf.sol_id_);

update BPM_SOL_VAR bsv SET bsv.ACT_DEF_ID_=(select BS.ACT_DEF_ID_ from BPM_SOLUTION bs where BS.SOL_ID_=bsv.sol_id_);

update BPM_SOL_USER bsu SET bsu.ACT_DEF_ID_=(select BS.ACT_DEF_ID_ from BPM_SOLUTION bs where BS.SOL_ID_=bsu.sol_id_);

update BPM_SOL_USERGROUP bsug SET bsug.ACT_DEF_ID_=(select BS.ACT_DEF_ID_ from BPM_SOLUTION bs where BS.SOL_ID_=bsug.sol_id_);

update BPM_TEST_SOL bts SET bts.ACT_DEF_ID_=(select BS.ACT_DEF_ID_ from BPM_SOLUTION bs where BS.SOL_ID_=bts.sol_id_);

update BPM_FV_RIGHT bfr SET bfr.ACT_DEF_ID_=(select BS.ACT_DEF_ID_ from BPM_SOLUTION bs where BS.SOL_ID_=bfr.sol_id_);

update BPM_TEST_CASE btc SET btc.ACT_DEF_ID_=(select BS.ACT_DEF_ID_ from BPM_SOLUTION bs where BS.SOL_ID_=btc.TEST_SOL_ID_);

alter table act_ru_task add token_ varchar(64);

alter table act_ru_task add urgent_times_ int default 0;
