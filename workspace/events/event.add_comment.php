<?php

	require_once(TOOLKIT . '/class.event.php');
	
	Class eventadd_comment extends Event{
		
		const ROOTELEMENT = 'add-comment';
		
		public $eParamFILTERS = array(
			'canofspam'
		);
			
		public static function about(){
			return array(
					 'name' => 'Add Comment',
					 'author' => array(
							'name' => 'Nils Hörrmann',
							'website' => 'http://projekte.nilshoerrmann.de/pompodium',
							'email' => 'post@nilshoerrmann.de'),
					 'version' => '1.0',
					 'release-date' => '2010-05-02T15:39:20+00:00',
					 'trigger-condition' => 'action[add-comment]');	
		}

		public static function getSource(){
			return '2';
		}

		public static function allowEditorToParse(){
			return true;
		}

		public static function documentation(){
			return '
        <h3>Success and Failure XML Examples</h3>
        <p>When saved successfully, the following XML will be returned:</p>
        <pre class="XML"><code>&lt;add-comment result="success" type="create | edit">
  &lt;message>Entry [created | edited] successfully.&lt;/message>
&lt;/add-comment></code></pre>
        <p>When an error occurs during saving, due to either missing or invalid fields, the following XML will be returned:</p>
        <pre class="XML"><code>&lt;add-comment result="error">
  &lt;message>Entry encountered errors when saving.&lt;/message>
  &lt;field-name type="invalid | missing" />
  ...
&lt;/add-comment></code></pre>
        <p>The following is an example of what is returned if any filters fail:</p>
        <pre class="XML"><code>&lt;add-comment result="error">
  &lt;message>Entry encountered errors when saving.&lt;/message>
  &lt;filter name="admin-only" status="failed" />
  &lt;filter name="send-email" status="failed">Recipient username was invalid&lt;/filter>
  ...
&lt;/add-comment></code></pre>
        <h3>Example Front-end Form Markup</h3>
        <p>This is an example of the form markup you can use on your frontend:</p>
        <pre class="XML"><code>&lt;form method="post" action="" enctype="multipart/form-data">
  &lt;input name="MAX_FILE_SIZE" type="hidden" value="5242880" />
  &lt;label>Name
    &lt;input name="fields[name]" type="text" />
  &lt;/label>
  &lt;label>Email
    &lt;input name="fields[email]" type="text" />
  &lt;/label>
  &lt;label>Website
    &lt;input name="fields[website]" type="text" />
  &lt;/label>
  &lt;label>Comments
    &lt;textarea name="fields[comments]" rows="15" cols="50">&lt;/textarea>
  &lt;/label>
  &lt;label>Date
    &lt;input name="fields[date]" type="text" />
  &lt;/label>
  &lt;input name="fields[article]" type="hidden" value="..." />
  &lt;label>Hide
    &lt;input name="fields[hide]" type="checkbox" />
  &lt;/label>
  &lt;input name="action[add-comment]" type="submit" value="Submit" />
&lt;/form></code></pre>
        <p>To edit an existing entry, include the entry ID value of the entry in the form. This is best as a hidden field like so:</p>
        <pre class="XML"><code>&lt;input name="id" type="hidden" value="23" /></code></pre>
        <p>To redirect to a different location upon a successful save, include the redirect location in the form. This is best as a hidden field like so, where the value is the URL to redirect to:</p>
        <pre class="XML"><code>&lt;input name="redirect" type="hidden" value="http://projekte.nilshoerrmann.de/pompodium/success/" /></code></pre>
        <h3>Can Of Spam Filter</h3>
        <p>
        To use the Can Of Spam filter, add the following field to your form:
      </p>
        <pre class="XML"><code>&lt;input name="canofspam" value="{$canofspam}" type="hidden" /></code></pre>';
		}
		
		public function load(){			
			if(isset($_POST['action']['add-comment'])) return $this->__trigger();
		}
		
		protected function __trigger(){
			include(TOOLKIT . '/events/event.section.php');
			return $result;
		}		

	}

