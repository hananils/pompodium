<?php

	/**
	 * @package toolkit
	 */

	require_once FACE . '/interface.exportablefield.php';

	/**
	 * The Author field allows Symphony Authors to be selected in your entries.
	 * It is a read only field, new Authors cannot be added from the Frontend using
	 * events.
	 *
	 * The Author field allows filtering by Author ID or Username.
	 * Sorting is done based on the Author's first name and last name.
	 */
	class FieldAuthor extends Field implements ExportableField {
		public function __construct(){
			parent::__construct();
			$this->_name = __('Author');
			$this->_required = true;

			$this->set('author_types', array());
		}

	/*-------------------------------------------------------------------------
		Definition:
	-------------------------------------------------------------------------*/

		public function canToggle(){
			return ($this->get('allow_multiple_selection') == 'yes' ? false : true);
		}

		public function getToggleStates(){
			$authors = AuthorManager::fetch();

			$states = array();
			foreach($authors as $a) {
				$states[$a->get('id')] = $a->getFullName();
			}

			return $states;
		}

		public function toggleFieldData(array $data, $newState, $entry_id=null){
			$data['author_id'] = $newState;
			return $data;
		}

		public function canFilter(){
			return true;
		}

		public function isSortable(){
			return $this->canToggle();
		}

		public function allowDatasourceOutputGrouping(){
			// Grouping follows the same rule as toggling.
			return $this->canToggle();
		}

		public function allowDatasourceParamOutput() {
			return true;
		}


	/*-------------------------------------------------------------------------
		Setup:
	-------------------------------------------------------------------------*/

		public function createTable(){
			return Symphony::Database()->query(
				"CREATE TABLE IF NOT EXISTS `tbl_entries_data_" . $this->get('id') ."` (
				  `id` int(11) unsigned NOT NULL auto_increment,
				  `entry_id` int(11) unsigned NOT NULL,
				  `author_id` int(11) unsigned NULL,
				  PRIMARY KEY  (`id`),
				  UNIQUE KEY `author` (`entry_id`, `author_id`),
				  KEY `author_id` (`author_id`)
				) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;"
			);
		}

	/*-------------------------------------------------------------------------
		Utilities:
	-------------------------------------------------------------------------*/

		public function set($field, $value){
			if($field === 'author_types' && !is_array($value)){
				$value = explode(',', $value);
			}
			$this->_fields[$field] = $value;
		}

		/**
		 * Determines based on the input value whether we want to filter the Author
		 * field by ID or by the Author's Username
		 *
		 * @since Symphony 2.2
		 * @param string $value
		 * @return string
		 *  Either `author_id` or `username`
		 */
		private static function __parseFilter($value) {
			return is_numeric($value) ? 'author_id' : 'username';
		}

	/*-------------------------------------------------------------------------
		Settings:
	-------------------------------------------------------------------------*/

		public function findDefaults(array &$settings){
			if(!isset($settings['allow_multiple_selection'])) $settings['allow_multiple_selection'] = 'no';
			if(!isset($settings['author_types'])) $settings['author_types'] = array('developer', 'manager', 'author');
		}

		public function displaySettingsPanel(XMLElement &$wrapper, $errors = null) {
			parent::displaySettingsPanel($wrapper, $errors);
			$div = new XMLElement('div', NULL, array('class' => 'two columns'));

			// Choose between Authors/Developers or both
			$label = Widget::Label(__('Author types'));
			$label->setAttribute('class', 'column');
			$types = $this->get('author_types');
			$options = array(
				array('author', empty($types) ? true : in_array('author', $types), __('Author')),
                array('manager', empty($types) ? true : in_array('manager', $types), __('Manager')),
				array('developer', empty($types) ? true : in_array('developer', $types), __('Developer'))
			);
			$label->appendChild(
				Widget::Select('fields['.$this->get('sortorder').'][author_types][]', $options, array(
					'multiple' => 'multiple'
				))
			);
			$div->appendChild($label);

			if(isset($errors['author_types'])) {
				$wrapper->appendChild(Widget::Error($div, $errors['author_types']));
			}
			else $wrapper->appendChild($div);

			$div = new XMLElement('div', NULL, array('class' => 'two columns'));
			// Allow multiple selection
			$label = Widget::Label();
			$label->setAttribute('class', 'column');
			$input = Widget::Input('fields['.$this->get('sortorder').'][allow_multiple_selection]', 'yes', 'checkbox');
			if($this->get('allow_multiple_selection') == 'yes') $input->setAttribute('checked', 'checked');
			$label->setValue(__('%s Allow selection of multiple authors', array($input->generate())));
			$div->appendChild($label);

			// Default to current logged in user
			$label = Widget::Label();
			$label->setAttribute('class', 'column');
			$input = Widget::Input('fields['.$this->get('sortorder').'][default_to_current_user]', 'yes', 'checkbox');
			if($this->get('default_to_current_user') == 'yes') $input->setAttribute('checked', 'checked');
			$label->setValue(__('%s Select current user by default', array($input->generate())));
			$div->appendChild($label);
			$wrapper->appendChild($div);

			$div = new XMLElement('div', NULL, array('class' => 'two columns'));
			$this->appendRequiredCheckbox($div);
			$this->appendShowColumnCheckbox($div);
			$wrapper->appendChild($div);
		}

		public function checkFields(array &$errors, $checkForDuplicates = true) {
			parent::checkFields($errors, $checkForDuplicates);

			$types = $this->get('author_types');
			if(empty($types)){
				$errors['author_types'] = __('This is a required field.');
			}

			return (is_array($errors) && !empty($errors) ? self::__ERROR__ : self::__OK__);
		}

		public function commit(){
			if(!parent::commit()) return false;

			$id = $this->get('id');

			if($id === false) return false;

			$fields = array();

			$fields['allow_multiple_selection'] = ($this->get('allow_multiple_selection') ? $this->get('allow_multiple_selection') : 'no');
			$fields['default_to_current_user'] = ($this->get('default_to_current_user') ? $this->get('default_to_current_user') : 'no');
			if($this->get('author_types') != '') $fields['author_types'] = implode(',', $this->get('author_types'));

			return FieldManager::saveSettings($id, $fields);
		}

	/*-------------------------------------------------------------------------
		Publish:
	-------------------------------------------------------------------------*/

		public function displayPublishPanel(XMLElement &$wrapper, $data = null, $flagWithError = null, $fieldnamePrefix = null, $fieldnamePostfix = null, $entry_id = null){
			$value = isset($data['author_id']) ? $data['author_id'] : NULL;

			if ($this->get('default_to_current_user') == 'yes' && empty($data) && empty($_POST)) {
				$value = array(Administration::instance()->Author->get('id'));
			}

			if(!is_array($value)) $value = array($value);

			$options = array();

			if ($this->get('required') != 'yes') $options[] = array(NULL, false, NULL);

			// Custom where to only show Authors based off the Author Types setting
			$types = $this->get('author_types');
			if(!empty($types)) {
				$types = implode('","', $this->get('author_types'));
				$where = 'user_type IN ("' . $types . '")';
			}

			$authors = AuthorManager::fetch('id', 'ASC', null, null, $where);
			$found = false;
			foreach($authors as $a){
				if(in_array($a->get('id'), $value)) $found = true;

				$options[] = array($a->get('id'), in_array($a->get('id'), $value), $a->getFullName());
			}

			// Ensure the selected Author is included in the options (incase
			// the settings change after the original entry was created)
			if(!$found && !is_null($value)) {
				$authors = AuthorManager::fetchByID($value);
				foreach($authors as $a){
					$options[] = array($a->get('id'), in_array($a->get('id'), $value), $a->getFullName());
				}
			}

			$fieldname = 'fields'.$fieldnamePrefix.'['.$this->get('element_name').']'.$fieldnamePostfix;
			if($this->get('allow_multiple_selection') == 'yes') $fieldname .= '[]';

			$label = Widget::Label($this->get('label'));
			$label->appendChild(Widget::Select($fieldname, $options, ($this->get('allow_multiple_selection') == 'yes' ? array('multiple' => 'multiple') : NULL)));

			if($flagWithError != NULL) $wrapper->appendChild(Widget::Error($label, $flagWithError));
			else $wrapper->appendChild($label);
		}

		public function processRawFieldData($data, &$status, &$message=null, $simulate=false, $entry_id=NULL){
			$status = self::__OK__;

			if(!is_array($data) && !is_null($data)) return array('author_id' => $data);

			if(empty($data)) return NULL;

			$result = array();
			foreach($data as $id) $result['author_id'][] = $id;

			return $result;
		}

	/*-------------------------------------------------------------------------
		Output:
	-------------------------------------------------------------------------*/

		public function appendFormattedElement(XMLElement &$wrapper, $data, $encode = false, $mode = null, $entry_id = null){
			if(!is_array($data['author_id'])) $data['author_id'] = array($data['author_id']);

			$list = new XMLElement($this->get('element_name'));
			$authors = AuthorManager::fetchByID($data['author_id']);

			foreach($authors as $author) {
				if(is_null($author)) continue;

				$list->appendChild(new XMLElement(
					'item',
					$author->getFullName(),
					array(
						'id' => (string)$author->get('id'),
						'username' => General::sanitize($author->get('username'))
					)
				));
			}
			$wrapper->appendChild($list);
		}

		public function prepareTableValue($data, XMLElement $link = null, $entry_id = null){
			$value = $this->prepareExportValue($data, ExportableField::LIST_OF + ExportableField::VALUE, $entry_id);

			if(is_null($value)) return null;

			return parent::prepareTableValue(array('value' => General::sanitize(implode(', ', $value))), $link, $entry_id);
		}

		public function getParameterPoolValue(array $data, $entry_id = null) {
			return $this->prepareExportValue($data, ExportableField::LIST_OF + ExportableField::AUTHOR, $entry_id);
		}

	/*-------------------------------------------------------------------------
		Export:
	-------------------------------------------------------------------------*/

		/**
		 * Return a list of supported export modes for use with `prepareExportValue`.
		 *
		 * @return array
		 */
		public function getExportModes() {
			return array(
				'listAuthor' =>			ExportableField::LIST_OF
										+ ExportableField::AUTHOR,
				'listAuthorObject' =>	ExportableField::LIST_OF
										+ ExportableField::AUTHOR
										+ ExportableField::OBJECT,
				'listAuthorToValue'	=>	ExportableField::LIST_OF
										+ ExportableField::AUTHOR
										+ ExportableField::VALUE,
				'listValue' =>			ExportableField::LIST_OF
										+ ExportableField::VALUE,
				'getPostdata' =>		ExportableField::POSTDATA
			);
		}

		/**
		 * Give the field some data and ask it to return a value using one of many
		 * possible modes.
		 *
		 * @param mixed $data
		 * @param integer $mode
		 * @param integer $entry_id
		 * @return array|null
		 */
		public function prepareExportValue($data, $mode, $entry_id = null) {
			$modes = (object)$this->getExportModes();

			// Make sure we have an array to work with:
			if (isset($data['author_id']) && is_array($data['author_id']) === false) {
				$data['author_id'] = array(
					$data['author_id']
				);
			}

			// Return the author IDs:
			if ($mode === $modes->listAuthor || $mode === $modes->getPostdata) {
				return isset($data['author_id'])
					? $data['author_id']
					: array();
			}

			// All other modes require full data:
			$authors = isset($data['author_id'])
				? AuthorManager::fetchByID($data['author_id'])
				: array();
			$items = array();

			foreach ($authors as $author) {
				if (is_null($author)) continue;

				if ($mode === $modes->listAuthorObject) {
					$items[] = $author;
				}

				else if ($mode === $modes->listValue) {
					$items[] = $author->getFullName();
				}

				else if ($mode === $modes->listAuthorToValue) {
					$items[$data['author_id']] = $author->getFullName();
				}
			}

			return $items;
		}

	/*-------------------------------------------------------------------------
		Filtering:
	-------------------------------------------------------------------------*/

		public function buildDSRetrievalSQL($data, &$joins, &$where, $andOperation = false) {
			$field_id = $this->get('id');

			if (self::isFilterRegex($data[0])) {
				$this->_key++;

				if (preg_match('/^regexp:/i', $data[0])) {
					$pattern = preg_replace('/^regexp:\s*/i', null, $this->cleanValue($data[0]));
					$regex = 'REGEXP';
				} else {
					$pattern = preg_replace('/^not-?regexp:\s*/i', null, $this->cleanValue($data[0]));
					$regex = 'NOT REGEXP';
				}

				if(strlen($pattern) == 0) return;

				$joins .= "
					LEFT JOIN
						`tbl_entries_data_{$field_id}` AS t{$field_id}_{$this->_key}
						ON (e.id = t{$field_id}_{$this->_key}.entry_id)
					JOIN
						`tbl_authors` AS t{$field_id}_{$this->_key}_authors
						ON (t{$field_id}_{$this->_key}.author_id = t{$field_id}_{$this->_key}_authors.id)
				";
				$where .= "
					AND (
						t{$field_id}_{$this->_key}.author_id {$regex} '{$pattern}'
						OR t{$field_id}_{$this->_key}_authors.username {$regex} '{$pattern}'
					)
				";

			}
			elseif ($andOperation) {
				foreach ($data as $value) {
					$this->_key++;
					$value = $this->cleanValue($value);

					if(fieldAuthor::__parseFilter($value) == "author_id") {
						$where .= "
							AND t{$field_id}_{$this->_key}.author_id = '{$value}'
						";
						$joins .= "
							LEFT JOIN
								`tbl_entries_data_{$field_id}` AS t{$field_id}_{$this->_key}
								ON (e.id = t{$field_id}_{$this->_key}.entry_id)
						";
					}
					else {
						$joins .= "
							LEFT JOIN
								`tbl_entries_data_{$field_id}` AS t{$field_id}_{$this->_key}
								ON (e.id = t{$field_id}_{$this->_key}.entry_id)
							JOIN
								`tbl_authors` AS t{$field_id}_{$this->_key}_authors
								ON (t{$field_id}_{$this->_key}.author_id = t{$field_id}_{$this->_key}_authors.id)
						";
						$where .= "
							AND t{$field_id}_{$this->_key}_authors.username = '{$value}'
						";
					}
				}

			}
			else {
				if (!is_array($data)) $data = array($data);

				foreach ($data as &$value) {
					$value = $this->cleanValue($value);
				}

				$this->_key++;
				$data = implode("', '", $data);
				$joins .= "
					LEFT JOIN
						`tbl_entries_data_{$field_id}` AS t{$field_id}_{$this->_key}
						ON (e.id = t{$field_id}_{$this->_key}.entry_id)
					JOIN
						`tbl_authors` AS t{$field_id}_{$this->_key}_authors
						ON (t{$field_id}_{$this->_key}.author_id = t{$field_id}_{$this->_key}_authors.id)
				";
				$where .= "
					AND (
						t{$field_id}_{$this->_key}.author_id IN ('{$data}')
						OR
						t{$field_id}_{$this->_key}_authors.username IN ('{$data}')
						)
				";
			}

			return true;
		}

	/*-------------------------------------------------------------------------
		Sorting:
	-------------------------------------------------------------------------*/

		public function buildSortingSQL(&$joins, &$where, &$sort, $order='ASC'){
			if(in_array(strtolower($order), array('random', 'rand'))) {
				$sort = 'ORDER BY RAND()';
			}
			else {
				$joins .= "
					LEFT OUTER JOIN `tbl_entries_data_".$this->get('id')."` AS `ed` ON (`e`.`id` = `ed`.`entry_id`)
					JOIN `tbl_authors` AS `a` ON (ed.author_id = a.id)
				";
				$sort = "ORDER BY `a`.`first_name` " . $order . ", `a`.`last_name` " . $order;
			}
		}

	/*-------------------------------------------------------------------------
		Events:
	-------------------------------------------------------------------------*/

		public function getExampleFormMarkup(){

			$authors = AuthorManager::fetch();

			$options = array();

			foreach($authors as $a){
				$options[] = array($a->get('id'), NULL, $a->getFullName());
			}

			$fieldname = 'fields['.$this->get('element_name').']';
			if($this->get('allow_multiple_selection') == 'yes') $fieldname .= '[]';

			$attr = array();

			if($this->get('allow_multiple_selection') == 'yes') $attr['multiple'] = 'multiple';

			$label = Widget::Label($this->get('label'));
			$label->appendChild(Widget::Select($fieldname, $options, $attr));

			return $label;
		}

	}
