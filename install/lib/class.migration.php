<?php

	/**
	 * @package install
	 */

	/**
	 * The Migration class is extended by updates files that contain the necessary
	 * logic to update the current installation to the migration version. In the
	 * future it is hoped Migrations will support downgrading as well.
	 */

	Abstract Class Migration {

		/**
		 * The current installed version of Symphony, before updating
		 * @var string
		 */
		static $existing_version = null;

		/**
		 * While we are supporting PHP5.2, we can't do this neatly as 5.2
		 * lacks late static binding. `self` will always refer to `Migration`,
		 * not the calling class, ie. `Migration_202`.
		 * In Symphony 2.4, we will support PHP5.3 only, and we can have this
		 * efficiency!
		 *
		 * @return boolean
		 *  True if successful, false otherwise
		 */
		abstract static function run($function, $existing_version = null);

		/**
		 * Return's the most current version that this migration provides.
		 * Note that just because the migration file is 2.3, the migration
		 * might only cater for 2.3 Beta 1 at this stage, hence the function.
		 *
		 * @return string
		 */
		abstract static function getVersion();

		/**
		 * Return's the string to this migration's release notes. Like `getVersion()`,
		 * this may not be the complete version, but rather the release notes for
		 * the Beta/RC.
		 *
		 * @return string
		 */
		abstract static function getReleaseNotes();

		/**
		 * This function will upgrade Symphony from the `self::$existing_version`
		 * to `getVersion()`.
		 *
		 * @return boolean
		 */
		static function upgrade(){
			return true;
		}

		/**
		 * This function is not implemented yet. It will take the `self::$existing_version`
		 * and downgrade the Symphony install to `getVersion`.
		 *
		 * @return boolean
		 */
		static function downgrade(){
			return true;
		}

		/**
		 * Called before an upgrade has started, this function allows migrations to
		 * include notices to display the user. These may be warnings about what is
		 * about to happen, or a description of what this upgrade provides.
		 *
		 * @return
		 *  An array of strings, where each string will become a list item.
		 */
		static function preUpdateNotes(){
			return array();
		}

		/**
		 * Called after an upgrade has started, this function allows migrations to
		 * include notices to display the user. These may be post upgrade steps such
		 * as new extensions that are available or required by the current version
		 *
		 * @return
		 *  An array of strings, where each string will become a list item.
		 */
		static function postUpdateNotes(){
			return array();
		}

	}
