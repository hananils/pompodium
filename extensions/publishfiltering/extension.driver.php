<?php
	
	class Extension_PublishFiltering extends Extension {
	/*-------------------------------------------------------------------------
		Extension definition
	-------------------------------------------------------------------------*/
		
		public static $params = null;
		
		public function about() {
			return array(
				'name'			=> 'Publish Filtering',
				'version'		=> '1.3',
				'release-date'	=> '2009-07-26',
				'author'		=> array(
					'name'			=> 'Nick Dunn',
					'website'		=> 'http://airlock.com',
					'email'			=> 'nick.dunn@airlock.com'
				),
				'description'	=> 'Add a filter box to publish index pages.'
			);
		}
		
		public function getSubscribedDelegates() {
			return array(
				array(
					'page'		=> '/backend/',
					'delegate'	=> 'InitaliseAdminPageHead',
					'callback'	=> 'initaliseAdminPageHead'
				)
			);
		}
		
	/*-------------------------------------------------------------------------
		Delegates:
	-------------------------------------------------------------------------*/
		
		public function initaliseAdminPageHead($context) {
			$page = $context['parent']->Page;
			
			// Include filter?
			if ($page instanceof ContentPublish and $page->_context['page'] == 'index') {
				$page->addStylesheetToHead(URL . '/extensions/publishfiltering/assets/filters.css', 'screen', 92370001);
				$page->addScriptToHead(URL . '/symphony/extension/publishfiltering/filters/?section=' . $page->_context['section_handle'], 92370002);
				$page->addScriptToHead(URL . '/extensions/publishfiltering/assets/filters.js', 92370003);
			}
			
		}
	}
	
?>