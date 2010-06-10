<?php

	Class extension_Typography extends Extension {

		public function about(){
			return array(
				'name' => 'Typography Text Formatters',
				'version' => '1.0.1',
				'release-date' => '2010-03-30',
				'author' => array(
					'name' => 'Tony Arnold',
					'website' => 'http://www.tonyarnold.com',
					'email' => 'tony@tonyarnold.com'
				),
				'description' => 'Format entries using the PHP Typography HTML formatter.'
			);
		}
		
		public function getSubscribedDelegates(){
			return array(
				array(
					'page' => '/system/preferences/',
					'delegate' => 'AddCustomPreferenceFieldsets',
					'callback' => 'appendPreferences'
				)
			);
		}
		
		public function appendPreferences($context){

			// Generate preference pane
			$group = new XMLElement('fieldset');
			$group->setAttribute('class', 'settings');
			$group->appendChild(new XMLElement('legend', __('Typography')));			
			
			// Append list of rulesets
			$label = Widget::Label();
			$preference = $this->_Parent->Configuration->get('rules', 'typography');
			$rules = array();
			$rulesets = new DirectoryIterator(EXTENSIONS . '/typography/lib/typography');
			foreach($rulesets as $set) {
				if(!$set->isDot() && $set->isFile()) {
					include($set->getPathname());
					$locale = explode('.', $set->getFilename(), 2);
					$typographer = call_user_func($locale[0] . 'Typography::about');
					$rules[] = array($typographer['handle'], (($preference == $typographer['handle']) ? true : false), $typographer['title']);
				}
			}
			asort($rules);
			$select = Widget::Select('settings[typography][rules]', $rules);
			$label->appendChild($select);
			$group->appendChild($label);

			// Append preferences								
			$context['wrapper']->appendChild($group);
						
		}	

	}
