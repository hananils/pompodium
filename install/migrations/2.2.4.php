<?php

	Class migration_224 extends Migration{

		static function run($function, $existing_version = null) {
			self::$existing_version = $existing_version;

			try{
				$canProceed = self::$function();

				return ($canProceed === false) ? false : true;
			}
			catch(DatabaseException $e) {
				Symphony::Log()->writeToLog('Could not complete upgrading. MySQL returned: ' . $e->getDatabaseErrorCode() . ': ' . $e->getDatabaseErrorMessage(), E_ERROR, true);

				return false;
			}
			catch(Exception $e){
				Symphony::Log()->writeToLog('Could not complete upgrading because of the following error: ' . $e->getMessage(), E_ERROR, true);

				return false;
			}
		}

		static function getVersion(){
			return '2.2.4';
		}

		static function getReleaseNotes(){
			return 'http://getsymphony.com/download/releases/version/2.2.4/';
		}

		static function upgrade(){
			Symphony::Configuration()->set('version', '2.2.4', 'symphony');
			if(Symphony::Configuration()->write() === false) {
				throw new Exception('Failed to write configuration file, please check the file permissions.');
			}
			else {
				return true;
			}
		}

	}
