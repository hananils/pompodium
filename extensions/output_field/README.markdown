# Output Field

An input field with advanced data source output for mail addresses and URIs.

- Version: 1.1
- Date: 8th May 2010
- Author: Nils Hörrmann, post@nilshoerrmann.de
- Repository: <http://github.com/nilshoerrmann/advanced_input>
- Requirements: Symphony CMS 2.0.6 or newer, <http://github.com/symphony/symphony-2/tree/master>

## Documentation

This extension extends Symphony's standard input field an offers a different data source output for mail addresses and URIs.

**Mail address** 

	<mailaddress alias="sam.symphonian" domain="symphony-cms.com" hash="9a6ea6ecaa6ce46c0dcfb8415993e638">sam.symphonian@symphony-cms.com</mailaddress>

- alias 
- domain
- hash (useful for Gravatar integration)

**URI** ([see PHP documentation](http://de.php.net/manual/en/function.parse-url.php))

    <website scheme="http" host="symphony-cms.com">http://symphony-cms.com</website>

- scheme, e.g. `http`
- host
- port
- user
- pass
- path
- query, after the question mark `?`
- fragment, after the hashmark `#`

### Change Log

Version 1.1 - 8th May 2010

- Renamed field from `advanced_input` to `output_field`

Version 1.0 - 25th January 2010

- Initial release