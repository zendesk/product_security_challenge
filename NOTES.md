# Implementation Notes

This solution uses Devise for authentication, running on Rails 6. Instead of opting to build as many features as
possible I have opted instead for holistic app security.

### Input sanitization and validation

Email and password validation is provided by Devise's `:validatible` module. 

 - email: stripped and downcased. Basic email format validation.
 - password: validates a minimum length of eight characters.
 
I've also updated the email database column so that all searches will be case insensitive. This ensures that 
ActiveRecord searches cannot be confused by case, e.g. when we are searching for a record based on user provided
parameters.

### Password hashing

Passwords are hashed using bcrypt with a work factor of 13. In production, the work factor should be adjusted 
based on the page timing that users find acceptable.  

Additionaly a [pepper](authenticator/config/initializers/devise.rb#L117) is used to mitigate against 
a situation in which a hash has been leaked but the server has not been compromised.

### Cookies

Authentication cookies use Rails 6 defaults:

 - encrypted against the `secret_key_base`
 - JSON format
 - `HostOnly`, `Secure`, `HttpOnly` flags are set

### Timing attack prevention

Timing attacks on password and remember me tokens are mitigated with Rails [SecureCompare](https://api.rubyonrails.org/classes/ActiveSupport/SecurityUtils.html#method-c-secure_compare).

**TODO** account emails could potentially be enumerated by measuring the timings on the password reset and confirmation
forms. To mitigate this, email processing should be moved to an async worker.     

### Logging

Request logging is provided in Logstash format for easy ingestion into Elasticsearch. User ID and remote IPs are added to
log events.

Both successful and unsuccessful authentication attempts are 
[logged](https://github.com/kiesia/product_security_challenge/blob/master/authenticator/config/initializers/warden_callbacks.rb). 

**TODO** add request IDs to log events for request tracing across resources.  

### CSRF prevention

CSRF protection is provided using Rails 
[CSRF countermeasures](https://guides.rubyonrails.org/security.html#csrf-countermeasures) on all forms.  

### Account confirmation

An email confirmation flow is provided by Devise. On registration, as user has 2 days in which to confirm their email 
address. On the third day their account will be blocked until they confirm the account.

**TODO** my main nitpick with Devise's email tokens is that only one token is persisted at a time. If a user triggers 
multiple reset emails, then only the newest one will be valid. 

This leads to really poor UX where users are unable to reset/confirm unless they open the latest email. Ideally multiple
tokens would remain valid and stored as a `has_many` relation on another table.   

### Password reset

A password reset email flow is provided by Devise.

### Notification emails

Emails are sent to users on password or email updates. When an email is updated, the notification is sent to the _old_
email address.

### HTTPS

A dockerized NGINX container provides a HTTPS proxy for the app. HTTPS is using a simple self-signed certificate. 
Using HTTPS in dev enables us to check for a number of issues and features, such as CSP, cookie flags, and mixed content.  
