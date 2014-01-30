# encoding: utf-8
require 'sqlite3'

#
# COMMAND
#
COMMAND_EMAIL_TO = 'simon.walther@liquid-concept.ch'
COMMAND_SUBJECT  = 'contact depuis le formulaire du site abyssinia.ch'

#
# SURVEY CONFIG & INIT
#

# Name of table, please start it with "survey_" prefix
# SURVEY_TABLE_NAME = 'T_email';

# # Connect to database and create table for current survey if not exists
# SURVEY_DB = SQLite3::Database.new File.expand_path('../../db/survey.db', __FILE__)
# SURVEY_DB.results_as_hash = true
# SURVEY_DB.execute <<-SQL
#   CREATE TABLE IF NOT EXISTS #{SURVEY_TABLE_NAME} (
#     id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
#     email TEXT
#   );
# SQL
