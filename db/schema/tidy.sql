alter table revision_sets DROP COLUMN parlrules_identifier;
alter table order_versions DROP COLUMN parlrules_identifier;
alter table order_versions DROP COLUMN root_number;
alter table fragment_versions DROP COLUMN parlrules_identifier;
alter table fragment_versions DROP COLUMN root_number;
alter table fragment_versions DROP COLUMN parlrules_article_identifier;
alter table fragment_versions DROP COLUMN article_current_number;
alter table fragment_versions DROP COLUMN article_root_number;
alter table orders DROP COLUMN parlrules_identifier;
alter table fragments DROP COLUMN parlrules_identifier;