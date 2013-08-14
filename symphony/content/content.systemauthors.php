<?php

	/**
	 * @package content
	 */

	/**
	 * Controller page for all Symphony Author related activity
	 * including making new Authors, editing Authors or deleting
	 * Authors from Symphony
	 */
	require_once(TOOLKIT . '/class.administrationpage.php');
	require_once(TOOLKIT . '/class.sectionmanager.php');
	require_once(CONTENT . '/class.sortable.php');

	Class contentSystemAuthors extends AdministrationPage{

		public $_Author;
		public $_errors = array();

		public function sort(&$sort, &$order, $params){
			if(is_null($sort) || $sort == 'name'){
				$sort = 'name';
				return AuthorManager::fetch("first_name $order,  last_name", $order);
			}

			return AuthorManager::fetch($sort, $order);
		}

		public function __viewIndex(){
			$this->setPageType('table');
			$this->setTitle(__('%1$s &ndash; %2$s', array(__('Authors'), __('Symphony'))));

			if (Administration::instance()->Author->isDeveloper() || Administration::instance()->Author->isManager()) {
				$this->appendSubheading(__('Authors'), Widget::Anchor(__('Create New'), Administration::instance()->getCurrentPageURL().'new/', __('Create a new author'), 'create button', NULL, array('accesskey' => 'c')));
			} else $this->appendSubheading(__('Authors'));

			Sortable::initialize($this, $authors, $sort, $order);

			$columns = array(
				array(
					'label' => __('Name'),
					'sortable' => true,
					'handle' => 'name'
				),
				array(
					'label' => __('Email Address'),
					'sortable' => true,
					'handle' => 'email'
				),
				array(
					'label' => __('Last Seen'),
					'sortable' => true,
					'handle' => 'last_seen'
				)
			);

			if (Administration::instance()->Author->isDeveloper() || Administration::instance()->Author->isManager()) {
				$columns = array_merge($columns, array(
					array(
						'label' => __('User Type'),
						'sortable' => true,
						'handle' => 'user_type'
					),
					array(
						'label' => __('Language'),
						'sortable' => true,
						'handle' => 'language'
					)
				));
			}

			$aTableHead = Sortable::buildTableHeaders(
				$columns, $sort, $order, (isset($_REQUEST['filter']) ? '&amp;filter=' . $_REQUEST['filter'] : '')
			);

			$aTableBody = array();

			if(!is_array($authors) || empty($authors)){
				$aTableBody = array(
					Widget::TableRow(array(Widget::TableData(__('None found.'), 'inactive', NULL, count($aTableHead))), 'odd')
				);
			}
			else{
				foreach($authors as $a){

					if(Administration::instance()->Author->isManager() && $a->isDeveloper()) {
						continue;
					}
					// Setup each cell
					if(
						(Administration::instance()->Author->isDeveloper() || (Administration::instance()->Author->isManager() && !$a->isDeveloper()))
						|| Administration::instance()->Author->get('id') == $a->get('id')
					) {
						$td1 = Widget::TableData(
							Widget::Anchor($a->getFullName(), Administration::instance()->getCurrentPageURL() . 'edit/' . $a->get('id') . '/', $a->get('username'), 'author')
						);
					} else {
						$td1 = Widget::TableData($a->getFullName(), 'inactive');
					}

					$td2 = Widget::TableData(Widget::Anchor($a->get('email'), 'mailto:'.$a->get('email'), __('Email this author')));

					if(!is_null($a->get('last_seen'))) {
						$td3 = Widget::TableData(
							DateTimeObj::format($a->get('last_seen'), __SYM_DATETIME_FORMAT__)
						);
					} else {
						$td3 = Widget::TableData(__('Unknown'), 'inactive');
					}

					if($a->isDeveloper()) {
						$type = 'Developer';
					}
					elseif($a->isManager()) {
						$type = 'Manager';
					}
					else {
						$type = 'Author';
					}
					$td4 = Widget::TableData(__($type));

					$languages = Lang::getAvailableLanguages();

					$td5 = Widget::TableData($a->get("language") == NULL ? __("System Default") : $languages[$a->get("language")]);

					if (Administration::instance()->Author->isDeveloper() || Administration::instance()->Author->isManager()) {
						if ($a->get('id') != Administration::instance()->Author->get('id')) {
							$td3->appendChild(Widget::Input('items['.$a->get('id').']', NULL, 'checkbox'));
						}
					}

					// Add a row to the body array, assigning each cell to the row
					if(Administration::instance()->Author->isDeveloper() || Administration::instance()->Author->isManager()) {
						$aTableBody[] = Widget::TableRow(array($td1, $td2, $td3, $td4, $td5));
					}
					else {
						$aTableBody[] = Widget::TableRow(array($td1, $td2, $td3));
					}
				}
			}

			$table = Widget::Table(
				Widget::TableHead($aTableHead),
				NULL,
				Widget::TableBody($aTableBody),
				'selectable'
			);

			$this->Form->appendChild($table);

			if(Administration::instance()->Author->isDeveloper() || Administration::instance()->Author->isManager()) {
				$tableActions = new XMLElement('div');
				$tableActions->setAttribute('class', 'actions');

				$options = array(
					array(NULL, false, __('With Selected...')),
					array('delete', false, __('Delete'), 'confirm', null, array(
						'data-message' => __('Are you sure you want to delete the selected authors?')
					))
				);

				/**
				 * Allows an extension to modify the existing options for this page's
				 * With Selected menu. If the `$options` parameter is an empty array,
				 * the 'With Selected' menu will not be rendered.
				 *
				 * @delegate AddCustomActions
				 * @since Symphony 2.3.2
				 * @param string $context
				 * '/system/authors/'
				 * @param array $options
				 *  An array of arrays, where each child array represents an option
				 *  in the With Selected menu. Options should follow the same format
				 *  expected by `Widget::__SelectBuildOption`. Passed by reference.
				 */
				Symphony::ExtensionManager()->notifyMembers('AddCustomActions', '/system/authors/', array(
					'options' => &$options
				));

				if(!empty($options)) {
					$tableActions->appendChild(Widget::Apply($options));
					$this->Form->appendChild($tableActions);
				}
			}

		}

		public function __actionIndex(){
			$checked = (is_array($_POST['items'])) ? array_keys($_POST['items']) : null;

			if(is_array($checked) && !empty($checked)){
				/**
				 * Extensions can listen for any custom actions that were added
				 * through `AddCustomPreferenceFieldsets` or `AddCustomActions`
				 * delegates.
				 *
				 * @delegate CustomActions
				 * @since Symphony 2.3.2
				 * @param string $context
				 *  '/system/authors/'
				 * @param array $checked
				 *  An array of the selected rows. The value is usually the ID of the
				 *  the associated object.
				 */
				Symphony::ExtensionManager()->notifyMembers('CustomActions', '/system/authors/', array(
					'checked' => $checked
				));

				if($_POST['with-selected'] == 'delete') {
					/**
					* Prior to deleting an author, provided with an array of Author ID's.
					*
					* @delegate AuthorPreDelete
					* @since Symphony 2.2
					* @param string $context
					* '/system/authors/'
					* @param array $author_ids
					*  An array of Author ID that are about to be removed
					*/
					Symphony::ExtensionManager()->notifyMembers('AuthorPreDelete', '/system/authors/', array('author_ids' => $checked));

					foreach($checked as $author_id) {
						$a = AuthorManager::fetchByID($author_id);
						if(is_object($a) && $a->get('id') != Administration::instance()->Author->get('id')) {
							AuthorManager::delete($author_id);
						}
					}

					redirect(SYMPHONY_URL . '/system/authors/');
				}
			}
		}

		// Both the Edit and New pages need the same form
		public function __viewNew(){
			$this->__form();
		}

		public function __viewEdit(){
			$this->__form();
		}

		public function __form(){

			require_once(TOOLKIT . '/class.field.php');

			// Handle unknown context
			if(!in_array($this->_context[0], array('new', 'edit'))) Administration::instance()->errorPageNotFound();

			if($this->_context[0] == 'new' && !Administration::instance()->Author->isDeveloper() && !Administration::instance()->Author->isManager()) {
				Administration::instance()->throwCustomError(
					__('You are not authorised to access this page.'),
					__('Access Denied'),
					Page::HTTP_STATUS_UNAUTHORIZED
				);
			}

			if(isset($this->_context[2])){
				switch($this->_context[2]){
					case 'saved':
						$this->pageAlert(
							__('Author updated at %s.', array(DateTimeObj::getTimeAgo()))
							. ' <a href="' . SYMPHONY_URL . '/system/authors/new/" accesskey="c">'
							. __('Create another?')
							. '</a> <a href="' . SYMPHONY_URL . '/system/authors/" accesskey="a">'
							. __('View all Authors')
							. '</a>'
							, Alert::SUCCESS);
					break;

					case 'created':
						$this->pageAlert(
							__('Author created at %s.', array(DateTimeObj::getTimeAgo()))
							. ' <a href="' . SYMPHONY_URL . '/system/authors/new/" accesskey="c">'
							. __('Create another?')
							. '</a> <a href="' . SYMPHONY_URL . '/system/authors/" accesskey="a">'
							. __('View all Authors')
							. '</a>'
							, Alert::SUCCESS);
					break;
				}
			}

			$this->setPageType('form');

			$isOwner = false;

			if(isset($_POST['fields'])) {
				$author = $this->_Author;
			}
			else if($this->_context[0] == 'edit') {
				if(!$author_id = (int)$this->_context[1]) redirect(SYMPHONY_URL . '/system/authors/');

				if(!$author = AuthorManager::fetchByID($author_id)){
					Administration::instance()->throwCustomError(
						__('The author profile you requested does not exist.'),
						__('Author not found'),
						Page::HTTP_STATUS_NOT_FOUND
					);
				}
			}
			else $author = new Author;

			if($this->_context[0] == 'edit' && $author->get('id') == Administration::instance()->Author->get('id')) $isOwner = true;

			if ($this->_context[0] == 'edit' && !$isOwner && !Administration::instance()->Author->isDeveloper() && !Administration::instance()->Author->isManager()) {
				Administration::instance()->throwCustomError(
					__('You are not authorised to edit other authors.'),
					__('Access Denied'),
					Page::HTTP_STATUS_FORBIDDEN
				);
			}

			$this->setTitle(__(($this->_context[0] == 'new' ? '%2$s &ndash; %3$s' : '%1$s &ndash; %2$s &ndash; %3$s'), array($author->getFullName(), __('Authors'), __('Symphony'))));
			$this->appendSubheading(($this->_context[0] == 'new' ? __('Untitled') : $author->getFullName()));
			$this->insertBreadcrumbs(array(
				Widget::Anchor(__('Authors'), SYMPHONY_URL . '/system/authors/'),
			));

			// Essentials
			$group = new XMLElement('fieldset');
			$group->setAttribute('class', 'settings');
			$group->appendChild(new XMLElement('legend', __('Essentials')));

			$div = new XMLElement('div');
			$div->setAttribute('class', 'two columns');

			$label = Widget::Label(__('First Name'), NULL, 'column');
			$label->appendChild(Widget::Input('fields[first_name]', $author->get('first_name')));
			$div->appendChild((isset($this->_errors['first_name']) ? Widget::Error($label, $this->_errors['first_name']) : $label));


			$label = Widget::Label(__('Last Name'), NULL, 'column');
			$label->appendChild(Widget::Input('fields[last_name]', $author->get('last_name')));
			$div->appendChild((isset($this->_errors['last_name']) ? Widget::Error($label, $this->_errors['last_name']) : $label));

			$group->appendChild($div);

			$label = Widget::Label(__('Email Address'));
			$label->appendChild(Widget::Input('fields[email]', $author->get('email')));
			$group->appendChild((isset($this->_errors['email']) ? Widget::Error($label, $this->_errors['email']) : $label));

			$this->Form->appendChild($group);

			// Login Details
			$group = new XMLElement('fieldset');
			$group->setAttribute('class', 'settings');
			$group->appendChild(new XMLElement('legend', __('Login Details')));

			$div = new XMLElement('div');

			$label = Widget::Label(__('Username'));
			$label->appendChild(Widget::Input('fields[username]', $author->get('username')));
			$div->appendChild((isset($this->_errors['username']) ? Widget::Error($label, $this->_errors['username']) : $label));

			// Only developers can change the user type. Primary account should NOT be able to change this
			if ((Administration::instance()->Author->isDeveloper() || Administration::instance()->Author->isManager()) && !$author->isPrimaryAccount()) {

				// Create columns
				$div->setAttribute('class', 'two columns');
				$label->setAttribute('class', 'column');

				// User type
				$label = Widget::Label(__('User Type'), NULL, 'column');

				$options = array(
					array('author', false, __('Author')),
					array('manager', $author->isManager(), __('Manager'))
				);

				if(Administration::instance()->Author->isDeveloper()) {
					$options[] = array('developer', $author->isDeveloper(), __('Developer'));
				}

				$label->appendChild(Widget::Select('fields[user_type]', $options));
				$div->appendChild($label);
			}

			$group->appendChild($div);

			// Password
			$fieldset = new XMLElement('fieldset', NULL, array('class' => 'two columns', 'id' => 'password'));
			$legend = new XMLElement('legend', __('Password'));
			$help = new XMLElement('i', __('Leave password fields blank to keep the current password'));
			$fieldset->appendChild($legend);
			$fieldset->appendChild($help);

			// Password reset
			if($this->_context[0] == 'edit' && (!Administration::instance()->Author->isDeveloper() || !Administration::instance()->Author->isManager() || $isOwner === true)) {
				$fieldset->setAttribute('class', 'three columns');

				$label = Widget::Label(NULL, NULL, 'column');
				$label->appendChild(Widget::Input('fields[old-password]', NULL, 'password', array('placeholder' => __('Old Password'))));
				$fieldset->appendChild((isset($this->_errors['old-password']) ? Widget::Error($label, $this->_errors['old-password']) : $label));
			}

			// New password
			$callback = Administration::instance()->getPageCallback();
			$placeholder = ($callback['context'][0] == 'edit' ? __('New Password') : __('Password'));
			$label = Widget::Label(NULL, NULL, 'column');
			$label->appendChild(Widget::Input('fields[password]', NULL, 'password', array('placeholder' => $placeholder)));
			$fieldset->appendChild((isset($this->_errors['password']) ? Widget::Error($label, $this->_errors['password']) : $label));

			// Confirm password
			$label = Widget::Label(NULL, NULL, 'column');
			$label->appendChild(Widget::Input('fields[password-confirmation]', NULL, 'password', array('placeholder' => __('Confirm Password'))));
			$fieldset->appendChild((isset($this->_errors['password-confirmation']) ? Widget::Error($label, $this->_errors['password']) : $label));

			$group->appendChild($fieldset);

			// Auth token
			if(Administration::instance()->Author->isDeveloper() || Administration::instance()->Author->isManager()) {
				$label = Widget::Label();
				$group->appendChild(Widget::Input('fields[auth_token_active]', 'no', 'hidden'));
				$input = Widget::Input('fields[auth_token_active]', 'yes', 'checkbox');

				if($author->isTokenActive()) {
					$input->setAttribute('checked', 'checked');
				}

				$temp = SYMPHONY_URL . '/login/' . $author->createAuthToken() . '/';
				$label->setValue(__('%s Allow remote login via', array($input->generate())) . ' <a href="' . $temp . '">' . $temp . '</a>');
				$group->appendChild($label);
			}

			$label = Widget::Label(__('Default Area'));

			$sections = SectionManager::fetch(NULL, 'ASC', 'sortorder');

			$options = array();

			// If the Author is the Developer, allow them to set the Default Area to
			// be the Sections Index.
			if($author->isDeveloper() || $author->isManager()) {
				$options[] = array('/blueprints/sections/', $author->get('default_area') == '/blueprints/sections/', __('Sections Index'));
			}

			if(is_array($sections) && !empty($sections)) {
				foreach($sections as $s) {
					$options[] = array($s->get('id'), $author->get('default_area') == $s->get('id'), $s->get('name'));
				}
			}

			/**
			* Allows injection or manipulation of the Default Area dropdown for an Author.
			* Take care with adding in options that are only valid for Developers, as if a
			* normal Author is set to that option, they will be redirected to their own
			* Author record.
			*
			*
			* @delegate AddDefaultAuthorAreas
			* @since Symphony 2.2
			* @param string $context
			* '/system/authors/'
			* @param array $options
			* An associative array of options, suitable for use for the Widget::Select
			* function. By default this will be an array of the Sections in the current
			* installation. New options should be the path to the page after the `SYMPHONY_URL`
			* constant.
			* @param string $default_area
			* The current `default_area` for this Author.
			*/
			Symphony::ExtensionManager()->notifyMembers('AddDefaultAuthorAreas', '/system/authors/', array(
				'options' => &$options,
				'default_area' => $author->get('default_area')
			));

			$label->appendChild(Widget::Select('fields[default_area]', $options));
			$group->appendChild($label);

			$this->Form->appendChild($group);

			// Custom Language Selection
			$languages = Lang::getAvailableLanguages();
			if(count($languages) > 1) {

				// Get language names
				asort($languages);

				$group = new XMLElement('fieldset');
				$group->setAttribute('class', 'settings');
				$group->appendChild(new XMLElement('legend', __('Custom Preferences')));

				$label = Widget::Label(__('Language'));

				$options = array(
					array(NULL, is_null($author->get('language')), __('System Default'))
				);

				foreach($languages as $code => $name) {
					$options[] = array($code, $code == $author->get('language'), $name);
				}
				$select = Widget::Select('fields[language]', $options);
				$label->appendChild($select);
				$group->appendChild($label);

				$this->Form->appendChild($group);
			}

			$div = new XMLElement('div');
			$div->setAttribute('class', 'actions');

			$div->appendChild(Widget::Input('action[save]', ($this->_context[0] == 'edit' ? __('Save Changes') : __('Create Author')), 'submit', array('accesskey' => 's')));

			if($this->_context[0] == 'edit' && !$isOwner && !$author->isPrimaryAccount()){
				$button = new XMLElement('button', __('Delete'));
				$button->setAttributeArray(array('name' => 'action[delete]', 'class' => 'button confirm delete', 'title' => __('Delete this author'), 'type' => 'submit', 'accesskey' => 'd', 'data-message' => __('Are you sure you want to delete this author?')));
				$div->appendChild($button);
			}

			$this->Form->appendChild($div);

			/**
			* Allows the injection of custom form fields given the current `$this->Form`
			* object. Please note that this custom data should be saved in own extension
			* tables and that modifying `tbl_authors` to house your data is highly discouraged.
			*
			* @delegate AddElementstoAuthorForm
			* @since Symphony 2.2
			* @param string $context
			* '/system/authors/'
			* @param XMLElement $form
			* The contents of `$this->Form` after all the default form elements have been appended.
			* @param Author $author
			* The current Author object that is being edited
			*/
			Symphony::ExtensionManager()->notifyMembers('AddElementstoAuthorForm', '/system/authors/', array(
				'form' => &$this->Form,
				'author' => $author
			));
		}

		public function __actionNew(){

			if(@array_key_exists('save', $_POST['action']) || @array_key_exists('done', $_POST['action'])) {

				$fields = $_POST['fields'];

				$this->_Author = new Author;
				$this->_Author->set('user_type', $fields['user_type']);
				$this->_Author->set('primary', 'no');
				$this->_Author->set('email', $fields['email']);
				$this->_Author->set('username', $fields['username']);
				$this->_Author->set('first_name', General::sanitize($fields['first_name']));
				$this->_Author->set('last_name', General::sanitize($fields['last_name']));
				$this->_Author->set('last_seen', NULL);
				$this->_Author->set('password', (trim($fields['password']) == '' ? '' : Cryptography::hash(Symphony::Database()->cleanValue($fields['password']))));
				$this->_Author->set('default_area', $fields['default_area']);
				$this->_Author->set('auth_token_active', ($fields['auth_token_active'] ? $fields['auth_token_active'] : 'no'));
				$this->_Author->set('language', isset($fields['language']) ? $fields['language'] : null);

				if($this->_Author->validate($this->_errors)) {
					if($fields['password'] != $fields['password-confirmation']){
						$this->_errors['password'] = $this->_errors['password-confirmation'] = __('Passwords did not match');
					}
					else if($author_id = $this->_Author->commit()) {

						/**
						 * Creation of a new Author. The Author object is provided as read
						 * only through this delegate.
						 *
						 * @delegate AuthorPostCreate
						 * @since Symphony 2.2
						 * @param string $context
						 * '/system/authors/'
						 * @param Author $author
						 *  The Author object that has just been created
						 */
						Symphony::ExtensionManager()->notifyMembers('AuthorPostCreate', '/system/authors/', array('author' => $this->_Author));

						redirect(SYMPHONY_URL . "/system/authors/edit/$author_id/created/");
					}
				}

				if(is_array($this->_errors) && !empty($this->_errors)) {
					$this->pageAlert(__('There were some problems while attempting to save. Please check below for problem fields.'), Alert::ERROR);
				}
				else {
					$this->pageAlert(
						__('Unknown errors occurred while attempting to save.')
						. '<a href="' . SYMPHONY_URL . '/system/log/">'
						. __('Check your activity log')
						. '</a>.'
						, Alert::ERROR);
				}
			}
		}

		public function __actionEdit(){

			if(!$author_id = (int)$this->_context[1]) redirect(SYMPHONY_URL . '/system/authors/');

			$isOwner = ($author_id == Administration::instance()->Author->get('id'));

			if(@array_key_exists('save', $_POST['action']) || @array_key_exists('done', $_POST['action'])) {

				$fields = $_POST['fields'];
				$this->_Author = AuthorManager::fetchByID($author_id);
				$authenticated = false;

				if($fields['email'] != $this->_Author->get('email')) $changing_email = true;

				// Check the old password was correct
				if(isset($fields['old-password']) && strlen(trim($fields['old-password'])) > 0 && Cryptography::compare(Symphony::Database()->cleanValue(trim($fields['old-password'])), $this->_Author->get('password'))) {
					$authenticated = true;
				}
				// Developers don't need to specify the old password, unless it's their own account
				else if(Administration::instance()->Author->isDeveloper()){
					$authenticated = true;
				}

				$this->_Author->set('id', $author_id);

				if ($this->_Author->isPrimaryAccount() || ($isOwner && Administration::instance()->Author->isDeveloper())){
					$this->_Author->set('user_type', 'developer'); // Primary accounts are always developer, Developers can't lower their level
				}
				elseif ((Administration::instance()->Author->isDeveloper() || Administration::instance()->Author->isManager()) && isset($fields['user_type'])){
					$this->_Author->set('user_type', $fields['user_type']); // Only developer can change user type
				}

				$this->_Author->set('email', $fields['email']);
				$this->_Author->set('username', $fields['username']);
				$this->_Author->set('first_name', General::sanitize($fields['first_name']));
				$this->_Author->set('last_name', General::sanitize($fields['last_name']));
				$this->_Author->set('language', isset($fields['language']) ? $fields['language'] : null);

				if(trim($fields['password']) != ''){
					$this->_Author->set('password', Cryptography::hash(Symphony::Database()->cleanValue($fields['password'])));
					$changing_password = true;
				}

				// Don't allow authors to set the Section Index as a default area
				// If they had it previously set, just save `null` which will redirect
				// the Author (when logging in) to their own Author record
				if(
					$this->_Author->get('user_type') == 'author'
					&& $fields['default_area'] == '/blueprints/sections/'
				) {
					$this->_Author->set('default_area', null);
				}
				else {
					$this->_Author->set('default_area', $fields['default_area']);
				}

				$this->_Author->set('auth_token_active', ($fields['auth_token_active'] ? $fields['auth_token_active'] : 'no'));

				if($this->_Author->validate($this->_errors)) {
					if(!$authenticated && ($changing_password || $changing_email)){
						if($changing_password) $this->_errors['old-password'] = __('Wrong password. Enter old password to change it.');
						elseif($changing_email) $this->_errors['old-password'] = __('Wrong password. Enter old one to change email address.');
					}

					elseif(($fields['password'] != '' || $fields['password-confirmation'] != '') && $fields['password'] != $fields['password-confirmation']){
						$this->_errors['password'] = $this->_errors['password-confirmation'] = __('Passwords did not match');
					}
					elseif($this->_Author->commit()){

						Symphony::Database()->delete('tbl_forgotpass', " `expiry` < '".DateTimeObj::getGMT('c')."' OR `author_id` = '".$author_id."' ");

						if($isOwner) Administration::instance()->login($this->_Author->get('username'), $this->_Author->get('password'), true);

						/**
						 * After editing an author, provided with the Author object
						 *
						 * @delegate AuthorPostEdit
						 * @since Symphony 2.2
						 * @param string $context
						 * '/system/authors/'
						 * @param Author $author
						 * An Author object
						 */
						Symphony::ExtensionManager()->notifyMembers('AuthorPostEdit', '/system/authors/', array('author' => $this->_Author));

						redirect(SYMPHONY_URL . '/system/authors/edit/' . $author_id . '/saved/');
					}

					else {
						$this->pageAlert(
							__('Unknown errors occurred while attempting to save.')
							. '<a href="' . SYMPHONY_URL . '/system/log/">'
							. __('Check your activity log')
							. '</a>.'
							, Alert::ERROR);
					}
				}
				else if(is_array($this->_errors) && !empty($this->_errors)) {
					$this->pageAlert(__('There were some problems while attempting to save. Please check below for problem fields.'), Alert::ERROR);
				}
			}
			else if(@array_key_exists('delete', $_POST['action'])) {

				/**
				 * Prior to deleting an author, provided with the Author ID.
				 *
				 * @delegate AuthorPreDelete
				 * @since Symphony 2.2
				 * @param string $context
				 * '/system/authors/'
				 * @param integer $author_id
				 *  The ID of Author ID that is about to be deleted
				 */
				Symphony::ExtensionManager()->notifyMembers('AuthorPreDelete', '/system/authors/', array('author_id' => $author_id));

				if(!$isOwner) {
					AuthorManager::delete($author_id);
					redirect(SYMPHONY_URL . '/system/authors/');
				}
				else {
					$this->pageAlert(__('You cannot remove yourself as you are the active Author.'), Alert::ERROR);
				}
			}
		}
	}
