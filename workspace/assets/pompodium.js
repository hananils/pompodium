/**
 * POMPODIUM ENSEMBLE: INTERACTIONS
 *	
 * Johanna Hörrmann <http://www.johannahoerrmann.de>
 * Nils Hörrmann <http://www.nilshoerrmann.de>
 * 
 * Some rights reserved (cc) 2008-2010 <http://creativecommons.org/licenses/by-nc-sa/3.0/>
 */


/**
 * Archive
 *
 * Dynamically load the Pompodium archives
 */
var Archive = new Class({

	Implements: Options,
	
	options: {
		error: 'The archive could not be loaded due to an internal error.',
		loading: 'Loading'
	},
	
	initialize: function(element, options) {
		this.element = document.id(element);
		this.setOptions(options);
	
		// Manage history
		this.manager = new HistoryManager();
		
		// Check history while browsing
		this.manager.addEvent('onHistoryChange', this.history);
		
		// Check hisotry on page load
		this.history();	
	},
	
	get: function(keyword, source) {
		
		// Collect data based on archive (date, tag, category)
		var data, typ;
		if(source[0] == 'date') {
			typ = 'Month';
			keyword = keyword + ' ' + source[1];
			data = { 
				'year': source[1], 
				'month': source[2] 
			};
		}
		if(source[0] == 'category') { 
			typ = 'Category';
			data = { 
				'category': source[1] 
			};
		}
		if(source[0] == 'tag') {
			typ = 'Tag';
			data = { 
				'tag': source[1] 
			};
		}
		
		// Stage
		var stage = document.id('archive').getElement('div:first-child');

		// Hide page information if available
		var about = stage.getElements('p');
		if(about.length > 0) {
			about.each(function(info) {
				info.set('tween', {
					property: 'opacity',
					link: 'chain',
					duration: 'short',
					transition: 'quint:in:out'
				});
				info.get('tween').start(0).chain(function() {
					info.destroy();
				});
			});
		}
		
		// Create archive overview if not available
		var overview = stage.getElement('ul.overview');
		if(overview == null) {
			overview = new Element('ul', {
				'class': 'overview'
			}).inject(stage);
		}
		
		// Show loading status
		var title = stage.getElement('h3');
		title.set('text', this.options.loading);
		title.addClass('loading');
		
		// Save overview dimensions
		var dimensionStart = overview.getSize();
		
		// Fading effect
		var fading = new Fx.Tween(overview, {
			property: 'opacity',
			link: 'chain',
			duration: 'short',
			transition: 'quint:in:out'
		});
		
		// Sliding effect
		var slide = new Fx.Tween(stage, {
			property: 'height',
			link: 'chain',
			duration: 'short'
		});
		
		// Request archive
		var site = window.location.href.split('/articles/')[0].split('/archive/')[0].split('/#/')[0];
		new Request.HTML({
			url: site + '/archive/', 
			evalScripts: false,
			
			// Fade current view while requesting archive
			onRequest: function() {
				fading.start(0);
			},
			
			// Insert new archive after loading
			onSuccess: function(response) {
				var response = $$(response)[0];
				if(response.getElement('li')) {
					var dimensionStage = stage.getSize();
					stage.setStyles({
						'overflow': 'hidden',
						'height': dimensionStage.y
					});
					response.replaces(overview);
					var dimensionTarget = stage.getElement('ul.overview').getSize();
					slide.start(dimensionStage.y + dimensionTarget.y - dimensionStart.y).chain(function() {
						fading.start(1);
						title.set('text', keyword);
						title.removeClass('loading');
						stage.setStyle('overflow', 'visible');
					});
				}
				else {
					this.fireEvent('failure');
				}
			},
			
			// Show message on failure
			onFailure: function() {
				$$('#archive div:first-child p', '#archive div:first-child ul').destroy();
				var error = new Element('p', {
					'text': this.options.error,
					'class': 'error'
				}).inject(stage);
			}
			
		}).get(data);
			
	},
	
	history: function() {
	
		// Check history
		var hash = this.manager.getCurrentHash();
		if(hash != '') {
			var link = $$('#archive div.meta a[href*=' + hash + ']')[0];
			if(link) {
				link.addClass('active');
				this.get(link.get('text'), hash.split('/'));		
			}
		}
		
	},
	
	scroll: function(element) {
	
		// Prepare archive scrolling
		var scroll = new Fx.Scroll($(document.body));
		var link = element.get('href').split('/articles/')[1];
		var keyword = element.get('text');
		if(element.getParent().hasClass('date')) {
			keyword = keyword.split(' ')[1];
		}
		
		// Save history
		this.manager.addState(link);
		
		// Get archive
		this.get(keyword, link.split('/'));		
		scroll.toElement('archive');
		
	}	

});


/**
 * SmoothHover
 *
 * Fades in children elements on hover and fade them out again on mouseleave
 */
var SmoothHover = new Class({

	Implements: Options,
	
	options: {
		targets: '.image',  
		visible: 0.7,
		invisible: 0
	},
	
	initialize: function(element, options) {
		this.element = document.id(element);
		this.setOptions(options);
		
		// Hide targets
		this.element.getElements(this.options.targets).fade('hide');
		
		// Add events
		this.element.addEvent('mouseenter', this.show.bind(this));
		this.element.addEvent('mouseleave', this.hide.bind(this));
	},
	
	toElement: function() {
		// Allow chaining
		return this.element;
	},

	show: function() {
		// Fade in target
		this.element.getElements(this.options.targets).fade(this.options.visible);
	},
	
	hide: function() {
		// Fade out target
		this.element.getElements(this.options.targets).fade(this.options.invisible);
	}

});

// SmoothHover shortcut
Element.implement({ 
	smoothhover: function(options) {
		return new SmoothHover(this, options); 
	}
});


/**
 * ValidateComment
 *
 * Validate comment before sending it to the server
 */
var ValidateComment = new Class({

	Implements: Options,
	
	options: {
		fields: [],
		optionals: [],
		missing: 'is missing',
		invalid: 'is not valid',
		error: 'error',
		handles: {
			mail: 'mail',
			website: 'website'
		}
	},
	
	initialize: function(element, options) {
		this.element = document.id(element);
		this.setOptions(options);
	},
	
	validate: function() {
		this.options.fields.each(function(field) {
		
			// Remove current messages
			this.clear(field, true);

			// Find empty fields
			if(field.get('value') == '' && !this.options.optionals.contains(field)) {
				this.highlight(field, this.options.missing);
			}
			
			// Find invalid mail addresses
			if(field.getProperty('name').contains(this.options.handles.mail) && field.get('value').test('^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$', 'i') == false && field.get('value') != '') {
				this.clear(field);
				this.highlight(field, this.options.invalid);
			}
			
			// Find invalid web addresses
			if(field.getProperty('name').contains(this.options.handles.website) && field.get('value').test('^(https?):\/\/(([A-Z0-9][A-Z0-9_-]*)(\.[A-Z0-9][A-Z0-9_-]*)+)(:(\d+))?\/?', 'i') == false && field.get('value') != '') {
				this.clear(field);
				this.highlight(field, this.options.invalid);
			}
			
		}.bind(this));
		
		// Check validity
		return this.isValid();
	},
	
	highlight: function(field, message) {
	
		// Get field label
		var label = field.getPrevious('label');
		
		// Hide current note
		label.getElement('i').setStyle('display', 'none');
		
		// Add error message
		var note = new Element('i', {
			'text': message,
			'class': this.options.error
		}).inject(label, 'bottom');
		
		// Highlight field and add automatic validation
		field.set({
			'class': this.options.error,
			'events': {
				'blur': function() {
					this.validate([field], []);
				}.bind(this)
			}
		});
		
	},
	
	clear: function(field, dispose) {
	
		// Get field label
		var label = field.getPrevious('label');
		
		// Remove error message
		if(label.getElement('i.' + this.options.error)) {
			label.getElement('i.' + this.options.error).destroy();			
		}
		
		// Show standard note again
		label.getElement('i').setStyle('display', 'inline');
		
		// Dispose all highlights
		if(dispose) {
			field.removeClass(this.options.error);
		}
		
	},
	
	isValid: function() {
		return this.element.getElements('.' + this.options.error).length == 0;
	}
	
});

/**
 * Relative Dates
 *
 * Provide relative date based on
 */
var RelativeDate = new Class({

	Implements: Options,
	
	options: {
		now: 'just now',
		minute: 'about a minute ago',
		minutes: '{minutes} minutes ago',
		hour: 'about an hour ago',
		hours: 'about {hours} hours ago',
		day: 'about a day ago',
		days: '{days} days ago',
		month: 'about a month ago',
		months: '{months} months ago',
		year: 'about a year ago',
		years: '{years} ago'
	},
	
	initialize: function(elements, options) {
		this.elements = $$(elements);
		this.setOptions(options);
		
		// Parse and store dates
		this.elements.each(function(element) {
			element.store('time', Date.parse(element.get('title')));
		});
		
		// Update every minute
		this.getDistance();
		this.getDistance.periodical(60000, this);
	},
	
	getDistance: function() {
	
		// Get current time
		var now = new Date;
		now = now.getTime();
		
		// Get time span
		this.elements.each(function(element) {
			var then = element.retrieve('time');
			var distance = Math.floor((now - then) / 60000);
			
			// Display time span in words
			element.set('text', this.inWords(distance));
		}.bind(this));
		
	},
	
	inWords: function(distance) {
	
		// Just now
		if(distance < 1) { 
			return this.options.now;  
		}
		
		// About a minute ago
		if(distance < 2) { 
			return this.options.minute; 
		}
		
		// Minutes ago
		if(distance < 45) { 
			return this.options.minutes.substitute({
				minutes: distance
			});
		}
		
		// About an hour ago
		if(distance < 90) { 
			return this.options.hour; 
		}
		
		// Hours ago
		if(distance < 60 * 20) {
			return this.options.hours.substitute({
				hours: Math.ceil(distance / 60)
			});
		}
		
		// About a day ago
		if(distance < 60 * 36) {
			return this.options.day
		}
		
		// Days ago
		if(distance < 60 * 24 * 30) {
			return this.options.days.substitute({
				days: Math.ceil(distance / (60 * 24))
			});
		}
		
		// About a month ago
		if(distance < 60 * 24 * 60) {
			return this.options.month
		}
		
		// Months ago
		if(distance < 60 * 24 * 300) {
			return this.options.months.substitute({
				months: Math.ceil(distance / (60 * 24 * 30))
			});
		}
		
		// About a year ago
		if(distance < 60 * 24 * 365) {
			return this.options.year
		}
		
		// Years ago
		return this.options.years.substitute({
			years: Math.ceil(distance / (60 * 24 * 365))
		});

	}

});

/**
 * Pompodium interactions
 *
 * Functions to be executed when the dom is ready
 */
window.addEvent('domready', function() {

	// Apply smooth hovering for image references
	var stage = document.id('content').getElements('strong.image').getParent().smoothhover();
	
	// Apply smooth scrolling for footnotes
	var body = document.id('body');
	if(body) {
		new Fx.SmoothScroll({
			links: body.getElements('a')
		});
	}

	// Handle comments	
	var comments = document.id('comments');
	if(comments) {

		// Add protocoll to web addresses inside comment form
		comments.getElement('input[name*=website]').addEvent('blur', function(event) {
			var value = event.target.get('value');
			if(value != '' && value.test("^(https?)", "i") == false) {
				event.target.set('value', 'http://' + value)
			}
		});

		// Setup comment validator
		var form = comments.getElement('form');
		var comment = new ValidateComment(form, {
			fields: $$('#comments input', '#comments textarea'),
			optionals: form.getElements('input[name*=website]'),
		}); 
		
		// Validate comment on submit
		form.addEvent('submit', function(event) {
			if(!comment.validate()) event.preventDefault();
		});
		
		// Show relative dates
		new RelativeDate('#comments abbr');

	}
	
	// Create dynamic, ajax based archive
	var archive = new Archive();
	
	// Archive navigation
	var stage = document.id('archive');
	if(stage) {
		stage.getElements('div.meta a').each(function(element) {
			var url = element.getProperty('href');
			var link = url.split('/articles/')[1];
			if(link) {
				var source = link.split('/');
				if(source[0] == 'date' || source[0] == 'category' || source[0] == 'tag') {
					element.addEvent('click', function(event) {
						event.preventDefault();
						
						// Set active state
						document.id('archive').getElements('div.meta a').removeClass('active');
						event.target.addClass('active');
						
						// Save history state
						archive.manager.addState(link);
						
						// Get archive
						archive.get(event.target.get('text'), source);
						
					});
				}
			}
		});
	}
	
	// Scroll to archive
	document.id('lead').getElements('li[class!=author] a').addEvent('click', function(event) {
		event.preventDefault();
		archive.scroll(event.target);
	});
	
});