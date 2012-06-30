#
# $Id: upgrade_212_to_213.sql 6049 2010-10-11 10:58:21Z ajdonnison $
# 
# DO NOT USE THIS SCRIPT DIRECTLY - USE THE INSTALLER INSTEAD.
#
# All entries must be date stamped in the correct format.
#
# 20090427
# adding config value to toggle use of TLS in SMTP connections
INSERT INTO `%dbprefix%config` (`config_id`, `config_name`, `config_value`, `config_group`, `config_type`)
VALUES (0, 'mail_smtp_tls', 'false', 'mail', 'checkbox'); 
