<?php
	/**
	 * @package toolkit
	 */
	/**
	 * The abstract Extension class contains common methods that most
	 * extensions require to get started in the Symphony environment. They
	 * include the installation updating and uninstallation, as well as a
	 * delegate subscription hook so an extension can perform custom logic
	 * at various times during Symphony execution.
	 */
	Abstract Class Extension{

		/**
		 * Determines that a new navigation group is to created in the Symphony backend
		 * @var integer
		 */
		const NAV_GROUP = 1;

		/**
		 * Determines that a new item is to be added to an existing navigation
		 * group in the Symphony backend
		 * @var integer
		 */
		const NAV_CHILD = 0;

		/**
		 * Default constructor for an Extension, at this time it does nothing
		 */
		public function __construct() {}

		/**
		 * Any logic that assists this extension in being installed such as
		 * table creation, checking for dependancies etc.
		 *
		 * @see toolkit.ExtensionManager#install()
		 * @return boolean
		 *  True if the install completely successfully, false otherwise
		 */
		public function install(){
			return true;
		}

		/**
		 * Logic that should take place when an extension is to be been updated
		 * when a user runs the 'Enable' action from the backend. The currently
		 * installed version of this extension is provided so that it can be
		 * compared to the current version of the extension in the file system.
		 * This is commonly done using PHP's version_compare function. Common
		 * logic done by this method is to update differences between extension
		 * tables.
		 *
		 * @see toolkit.ExtensionManager#update()
		 * @param string $previousVersion
		 *  The currently installed version of this extension from the
		 *  `tbl_extensions` table. The current version of this extension is
		 *  provided by the about() method.
		 * @return boolean
		 */
		public function update($previousVersion=false){
			return true;
		}

		/**
		 * Any logic that should be run when an extension is to be uninstalled
		 * such as the removal of database tables.
		 *
		 * @see toolkit.ExtensionManager#uninstall()
		 * @return boolean
		 */
		public function uninstall(){
			return true;
		}

		/**
		 * Extensions can be disabled in the backend which stops them from
		 * functioning by removing their delegate subscription information
		 * but keeps their settings intact (usually stored in the database).
		 * This method runs when a user selects Enable from the Symphony
		 * backend.
		 *
		 * @see toolkit.ExtensionManager#enable()
		 * @return boolean
		 */
		public function enable(){
			return true;
		}

		/**
		 * This method runs when a user selects Disable from the Symphony
		 * backend.
		 *
		 * @see toolkit.ExtensionManager#enable()
		 * @return boolean
		 */
		public function disable(){
			return true;
		}

		/**
		 * The about method allows an extension to provide
		 * information about itself as an associative array. eg.
		 * `
		 *		'name' => 'Name of Extension',
		 *		'version' => '1.8',
		 *		'release-date' => 'YYYY-MM-DD',
		 *		'author' => array(
		 *			'name' => 'Author Name',
		 *			'website' => 'Author Website',
		 *			'email' => 'Author Email'
		 *		),
		 *		'description' => 'A description about this extension'
		 * `
		 * @deprecated Since Symphony 2.3, the `about()` function is deprecated for extensions
		 *  in favour of the `extension.meta.xml` file. It will be removed in Symphony 2.4.
		 * @return array
		 *  An associative array describing this extension.
		 */
		public function about() {
			return array();
		}

		/**
		 * Extensions use delegates to perform logic at certain times
		 * throughout Symphony. This function allows an extension to
		 * subscribe to a delegate which will notify the extension when it
		 * is used so that it can perform it's custom logic.
		 * This method returns an array with the delegate name, delegate
		 * namespace, and then name of the method that should be called.
		 * The method that is called is passed an associative array containing
		 * the current context which is the current page object
		 * and any other variables that is passed via this delegate. eg.
		 *
		 * `array(
		 *		array(
		 *			'page' => '/current/path/',
		 *			'delegate' => 'DelegateName',
		 *			'callback' => 'functionToCall'
		 *		)
		 *	)`
		 *
		 * @return array
		 */
		public function getSubscribedDelegates(){
			return array();
		}

		/**
		 * When the Symphony navigation is being generated, this method will be
		 * called to allow extensions to inject any custom backend pages into the
		 * navigation.
		 *
		 * The extension can also inject link items into existing
		 * group's of the navigation using the 'location' key, which will accept a numeric
		 * index of the existing group, or the handle of an existing group. Navigation items
		 * in Symphony are initially provided from the `ASSETS . /navigation.xml` file
		 * which defines the default Blueprints and System groups. The indexes for these
		 * groups are 100 and 200 respectively.
		 *
		 * A simple case would look like this.
		 *
		 * `return array(
		 *		array(
		 *			'name' => 'Extension Name',
		 *			'link' => '/link/relative/to/extension/handle/',
		 *			'location' => 200
		 *		)
		 *	)
		 * );`
		 *
		 * If an extension wants to create a new group in the navigation
		 * it is possible by returning an array with the group information and then an
		 * array of links for this group. Groups cannot provide a link, this is done
		 * by the children. An example of a returned navigation
		 * array is provided below.
		 *
		 * `return array(
		 *		'name' => 'New Group',
		 *		'children' => array(
		 *			array(
		 *				'name' => 'Extension Name',
		 *				'link' => '/link/relative/to/extension/handle/'
		 *			)
		 *		)
		 * );`
		 *
		 * All links are relative to the Extension by default
		 * (ie. `EXTENSIONS . /extension_handle/`. )
		 * Set the 'relative' key to false tobe able to create links
		 * relative to /symphony/.
		 *
		 * `return array(
		 *		array(
		 *			'name' => 'Extension Name',
		 *			'link' => '/link/retative/to/symphony/',
		 *			'relative' => false,
		 *			'location' => 200
		 *		)
		 *	)
		 * );`
		 *
		 * You can also set the `target` attribute on your links via the 'target' attribute.
		 * This works both on links in standard menus and on child links of groups.
		 *
		 * `return array(
		 *		array(
		 *			'name' => 'Extension Name',
		 *			'link' => '/.../',
		 *			'target' => '_blank'
		 *		)
		 *	)
		 * );`
		 *
		 * Links can also be hidden dynamicaly usign two other keys:
		 * 'visible' and 'limit'. When 'visible' is set to 'no', the link
		 * will not be rendered. Leave unset or set it dynamycally in order
		 * to fit your needs
		 *
		 * `return array(
		 *		array(
		 *			'name' => 'Extension Name',
		 *			'link' => '/.../',
		 *			'visible' => $this->shouldWeOrNot() ? 'yes' : 'no'
		 *		)
		 *	)
		 * );`
		 *
		 * The 'limit' key is specificaly designed to restrict the rendering process
		 * of a link if the current user does not have access to it based on its role.
		 * Symphony supports three basic roles witch are 'author', 'developer' and 'primary'.
		 *
		 * Note that setting 'visible' to 'no' will hide the link no matter what.
		 *
		 * `return array(
		 *		array(
		 *			'name' => 'Developers Only',
		 *			'link' => '/developers-only/',
		 *			'limit' => 'developer'
		 *		)
		 *	)
		 * );`
		 *
		 * The 'limit' key is also available for navigation groups.
		 *
		 * Note that if an extension wants to edit the current navigation,
		 * this is not possible through this function and rather it should be done using the
		 * `NavigationPreRender` delegate.
		 *
		 * @link http://github.com/symphonycms/symphony-2/blob/master/symphony/assets/navigation.xml
		 * @return array
		 *  An associative array of navigation items to add to the Navigation. This function
		 *  defaults to returning null, which adds nothing to the Symphony navigation
		 */
		public function fetchNavigation(){
			return null;
		}
	}
