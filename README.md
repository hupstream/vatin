# VAT Ninja

Naïve resolution service for French VAT Identification Numbers.

For France & Portugal at least, where it's really easy to do:
TVA number = f(SIREN). That's all we need at this point.

It would be great to support other countries too, but we don't
have the knowledge for this, yet. Contributions welcome.
The construction looks different, depending on the country
(https://en.wikipedia.org/wiki/VAT_identification_number).

Here's the deal so far:

 - http://?/ will run this code until 2016 January 31st, at least.
 - GET http://?/{country}/{valid_SIREN} will return a valid corresponding TVA IN,
   plus a validation/details link against http://ec.europa.eu/taxation_customs/vies/ .
 - this service DOES NOT validate existence of legal entities.
 - the service is read-only for now.
 - contributions & ideas welcome.

### License

GPL-3.0.

### Disclaimer

It works for us so far. There's no guarantee this works for you.

### Changelog

#### 0.0.1, 2015-02-04

 * First version

