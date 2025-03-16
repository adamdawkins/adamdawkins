# IndieWeb Personal Website Implementation Checklist

## Phase 1: Foundation Setup

### Project Initialization
- [x] Create new Rails application with PostgreSQL
- [x] Set up RSpec and configure test framework
- [ ] Add SimpleCov for test coverage reporting
- [x] Configure Heroku deployment setup
- [x] Set up GitHub repository with CI workflow
- [x] Add essential gems to Gemfile:
  - [x] rspec-rails
  - [x] redcarpet for Markdown
- [x] Configure database for development, test, and production
- [x] Create application layout with proper doctype and meta tags
- [x] Create home controller with index page
- [x] Write tests for home controller

### Authentication Foundation
- [x] Create User model with essential fields
- [x] Implement has_secure_password
- [x] Implement login/logout functionality (via AdamController)
- [x] Create current_user helper method (authenticate_adam!)
- [x] Create login form view
- [ ] Write controller tests for authentication
- [ ] Add flash messages for authentication events
- [ ] Create authentication service object

### Media Attachments Support
- [ ] Configure Active Storage
- [ ] Create MediaAttachment model with:
  - [ ] Polymorphic association (attachable)
  - [ ] Caption field
  - [ ] File attachment
- [ ] Create migration with proper indices
- [ ] Create model validations for file types
- [ ] Write model specs for MediaAttachment
- [ ] Create media upload service object
- [ ] Write service specs with mocked uploads
- [ ] Implement controller concern for handling attachments
- [ ] Create factory for media attachments
- [ ] Implement validation service for file types and sizes
- [ ] Test error handling for uploads

## Phase 2: Core Models & Data Structure

### Base Content Models
- [ ] Create Content concern module with:
  - [ ] Shared validation methods
  - [ ] Slug generation functionality
  - [ ] Published status management
  - [ ] Syndication URLs serialization
- [ ] Write specs for Content concern
- [x] Create Note model with:
  - [x] Body field (text)
  - [x] Published_at field (datetime)
  - [ ] Slug field (string)
  - [ ] Syndication_urls field (text)
  - [ ] Has_many relationship with MediaAttachments
- [x] Write model specs for Note
- [x] Create Article model with:
  - [x] Title field (string)
  - [x] Body field (text)
  - [x] Published_at field (datetime)
  - [ ] Slug field (string)
  - [ ] Syndication_urls field (text)
  - [ ] Has_many relationship with MediaAttachments
- [x] Write model specs for Article
- [ ] Implement slug generation service
- [ ] Test slug generation edge cases
- [ ] Create factories for Note and Article
- [ ] Set up database migrations with proper indices

### Specialized Content Models
- [ ] Create MovieReview model with:
  - [ ] Title field (string)
  - [ ] Year field (integer)
  - [ ] Quality_rating field (integer)
  - [ ] Performance_rating field (integer)
  - [ ] Story_rating field (integer)
  - [ ] Enjoyment_rating field (integer)
  - [ ] Total_rating field (integer, computed)
  - [ ] Body field (text)
  - [ ] Published_at, slug, syndication_urls fields
- [ ] Create Listen model with:
  - [ ] Track_name field (string)
  - [ ] Artist field (string)
  - [ ] Album field (string, optional)
  - [ ] Listened_at field (datetime)
  - [ ] Source_url field (string)
- [ ] Create Talk model with:
  - [ ] Title field (string)
  - [ ] Body field (text)
  - [ ] Event_name field (string)
  - [ ] Event_date field (date)
  - [ ] Slides_url field (string, optional)
  - [ ] Recording_url field (string, optional)
  - [ ] Published_at, slug, syndication_urls fields
- [ ] Implement rating calculation service for MovieReview
- [ ] Write model specs for all specialized models
- [ ] Create model validations for all fields
- [ ] Create factories for testing each model
- [ ] Write shared specs for common content behavior
- [ ] Create database migrations with proper indices

### Unified Activity Model
- [ ] Create Activity model with:
  - [ ] Trackable_id field (integer)
  - [ ] Trackable_type field (string)
  - [ ] Created_at timestamp
  - [ ] Polymorphic association named 'trackable'
- [ ] Write model specs for Activity
- [ ] Implement after_create callback in content models
- [ ] Implement after_destroy callback in content models
- [ ] Create ActivityCreationService
- [ ] Write specs for activity creation service
- [ ] Test callback behavior in content models
- [ ] Create factory for activities
- [ ] Add database indices for polymorphic relationship
- [ ] Optimize query performance for activity retrieval

## Phase 3: Content Type Implementation

### Notes Implementation
- [x] Create NotesController with actions:
  - [x] Index
  - [x] Show
  - [x] New
  - [x] Create
  - [x] Edit
  - [x] Update
  - [x] Destroy
- [x] Write controller specs for each action
- [x] Add authorization checks for admin actions
- [x] Create routes for notes
- [ ] Implement CreateNoteService
- [ ] Write specs for note creation service
- [x] Create markdown parsing service
- [ ] Test markdown parsing edge cases
- [x] Create views for notes:
  - [x] Index view
  - [x] Show view
  - [x] Form partial
  - [ ] Media attachment handling
- [x] Test view rendering and form submission
- [x] Implement permalink structure based on slugs

### Articles Implementation
- [x] Create ArticlesController with actions:
  - [x] Index
  - [x] Show
  - [x] New
  - [x] Create
  - [x] Edit
  - [x] Update
  - [x] Destroy
- [x] Write controller specs for each action
- [x] Add authorization checks for admin actions
- [x] Create routes for articles
- [ ] Implement CreateArticleService
- [x] Write specs for article creation service
- [x] Enhance markdown parsing for articles
- [x] Test advanced markdown features
- [x] Create views for articles:
  - [x] Index view
  - [x] Show view
  - [x] Form partial
  - [ ] Media attachment handling
- [x] Test view rendering and form submission
- [x] Implement permalink structure based on slugs

### Movie Reviews Implementation
- [ ] Create MovieReviewsController with actions:
  - [ ] Index
  - [ ] Show
  - [ ] New
  - [ ] Create
  - [ ] Edit
  - [ ] Update
  - [ ] Destroy
- [ ] Write controller specs for each action
- [ ] Add authorization checks for admin actions
- [ ] Create routes for movie reviews
- [ ] Implement CreateMovieReviewService
- [ ] Write specs for review creation service
- [ ] Create RatingCalculationService
- [ ] Test rating calculation edge cases
- [ ] Create views for movie reviews:
  - [ ] Index view
  - [ ] Show view with rating display
  - [ ] Form partial with rating inputs
  - [ ] Movie metadata display
- [ ] Test view rendering and form submission
- [ ] Implement permalink structure based on slugs

### Listens Implementation
- [ ] Create LastfmApiClient
- [ ] Write specs for API client with stubbed responses
- [ ] Create ListenImportService
- [ ] Test import service with sample data
- [ ] Create background job for scheduled imports
- [ ] Write specs for background job functionality
- [ ] Create ListensController with actions:
  - [ ] Index
  - [ ] Show
  - [ ] Import (admin only)
- [ ] Write controller specs
- [ ] Create routes for listens
- [ ] Create views for listens:
  - [ ] Index view
  - [ ] Show view
  - [ ] Statistics view
- [ ] Test view rendering
- [ ] Add proper timestamp formatting

### Talks Implementation
- [ ] Create TalksController with actions:
  - [ ] Index
  - [ ] Show
  - [ ] New
  - [ ] Create
  - [ ] Edit
  - [ ] Update
  - [ ] Destroy
- [ ] Write controller specs for each action
- [ ] Add authorization checks for admin actions
- [ ] Create routes for talks
- [ ] Implement CreateTalkService
- [ ] Write specs for talk creation service
- [ ] Create URL validation service
- [ ] Test URL validation edge cases
- [ ] Create views for talks:
  - [ ] Index view
  - [ ] Show view with event details
  - [ ] Form partial with metadata fields
  - [ ] Links to slides and recordings
- [ ] Test view rendering and form submission
- [ ] Implement permalink structure based on slugs

## Phase 4: IndieWeb Features

### Microformats Implementation
- [x] Create HCard helper for profile
- [ ] Test h-card output structure
- [x] Create HEntry helpers for content types
- [ ] Test h-entry output for different content types
- [x] Create view partials:
  - [x] Profile partial with h-card
  - [x] Content partials with h-entry
  - [ ] Specialized partials for each content type
- [ ] Implement MicroformatService for validation
- [ ] Test microformat structure against spec
- [x] Update existing views to incorporate microformats
- [ ] Create tests for edge cases
- [ ] Validate against the microformats2 specification

### Webmentions - Receiving
- [ ] Create Webmention model with:
  - [ ] Source field (URL of mentioning site)
  - [ ] Target field (URL of mentioned content)
  - [ ] Verified field (boolean)
  - [ ] Payload field (serialized JSON)
  - [ ] Mentioned_type and mentioned_id fields (polymorphic)
- [ ] Write model specs for Webmention
- [ ] Create WebmentionsController with endpoint action
- [ ] Test webmention endpoint functionality
- [ ] Implement WebmentionVerificationService
- [ ] Test verification with stubbed HTTP requests
- [ ] Create WebmentionProcessingJob
- [ ] Test job processing behavior
- [ ] Create view partials for displaying webmentions:
  - [ ] List of webmentions on content
  - [ ] Individual webmention display
  - [ ] Different types of webmentions
- [ ] Create database migrations with proper indices
- [ ] Add routes for webmention endpoint

### Webmentions - Sending
- [ ] Create WebmentionDiscoveryService
- [ ] Test discovery with stubbed HTML responses
- [ ] Implement WebmentionSendingService
- [ ] Test sending with mocked HTTP requests
- [ ] Create WebmentionSendingJob
- [ ] Test job behavior and retry logic
- [ ] Implement after_save callbacks in content models
- [ ] Test callback functionality
- [ ] Add tracking for sent webmentions
- [ ] Implement error handling and reporting

### IndieAuth Implementation
- [ ] Create AuthorizationController with:
  - [ ] Authorization endpoint
  - [ ] Token endpoint
- [ ] Test controller endpoints
- [ ] Implement TokenService
- [ ] Test token generation and validation
- [ ] Create ClientVerificationService
- [ ] Test client verification
- [ ] Create views for auth flow:
  - [ ] Authorization confirmation
  - [ ] Error pages
  - [ ] Success pages
- [ ] Add authorization headers and links
- [ ] Test header inclusion
- [ ] Validate implementation against IndieAuth spec
- [ ] Create routes for auth endpoints

## Phase 5: Integration & Syndication

### Mastodon Integration
- [ ] Create MastodonApiClient
- [ ] Test client with stubbed responses
- [ ] Implement MastodonSyndicationService
- [ ] Test syndication service functionality
- [ ] Create MastodonSyndicationJob
- [ ] Test job behavior and retry logic
- [ ] Implement configuration:
  - [ ] Environment variables
  - [ ] Instance URL config
  - [ ] Token storage
  - [ ] User preferences
- [ ] Test content formatting for Mastodon
- [ ] Implement media upload handling
- [ ] Add error handling for API limits and failures
- [ ] Create syndication URL storage

### LinkedIn Integration
- [ ] Create LinkedInApiClient
- [ ] Test client with stubbed responses
- [ ] Implement LinkedInSyndicationService
- [ ] Test syndication service functionality
- [ ] Create LinkedInSyndicationJob
- [ ] Test job behavior and retry logic
- [ ] Implement configuration:
  - [ ] Environment variables
  - [ ] OAuth token management
  - [ ] Authentication flow
  - [ ] User preferences
- [ ] Test content formatting for LinkedIn
- [ ] Implement media handling
- [ ] Add error handling for API limits
- [ ] Create syndication URL storage

### Syndication Management
- [ ] Create SyndicationManager service
- [ ] Test manager service coordination
- [ ] Implement SyndicationQueueService
- [ ] Test queue functionality
- [ ] Create syndication UI components:
  - [ ] Toggles in content forms
  - [ ] Status display
  - [ ] Manual triggers
  - [ ] Error reporting
- [ ] Create SyndicationReportingService
- [ ] Test reporting accuracy
- [ ] Implement content-specific syndication rules
- [ ] Integrate with all content types
- [ ] Add retry mechanisms for failed syndications

## Phase 6: UI & Activity Feed

### Homepage Implementation
- [x] Create HomeController
- [x] Test controller actions
- [ ] Implement ProfileService
- [ ] Test profile data formatting
- [x] Create LatestContentService
- [ ] Test content aggregation
- [x] Create homepage views:
  - [x] Profile section with h-card
  - [x] Content type navigation
  - [x] Latest content feed
  - [ ] Responsive layout
- [ ] Add meta tags and SEO:
  - [ ] Open Graph tags
  - [ ] Twitter card tags
  - [ ] Description and title
  - [ ] Canonical URLs
- [x] Test view rendering
- [ ] Verify responsive design

### Activity Feed
- [ ] Create ActivitiesController
- [ ] Test controller actions
- [ ] Implement ActivityTimelineService
- [ ] Test query performance
- [ ] Create view components:
  - [ ] Activity stream
  - [ ] Content type-specific partials
  - [ ] Pagination controls
  - [ ] Infinite scroll
- [ ] Create ActivityPresenter
- [ ] Test presenter functionality
- [ ] Implement polymorphic rendering
- [ ] Test pagination behavior
- [ ] Optimize loading performance
- [ ] Add content type filtering

### Responsive Design
- [ ] Apply custom CSS framework
- [ ] Create responsive components:
  - [ ] Mobile navigation
  - [ ] Responsive media handling
  - [ ] Flexible layouts
  - [ ] Breakpoint styles
- [ ] Implement content-specific designs:
  - [ ] Note card design
  - [ ] Article layout
  - [ ] Movie review presentation
  - [ ] Listen activity display
  - [ ] Talk information layout
- [ ] Add accessibility features:
  - [ ] ARIA attributes
  - [ ] Keyboard navigation
  - [ ] Screen reader compatibility
  - [ ] Color contrast
- [ ] Create print styles
- [ ] Test responsive behavior
- [ ] Test component rendering
- [ ] Verify accessibility compliance
- [ ] Test print output

## Final Checks and Deployment

### Test Coverage
- [ ] Run full test suite
- [ ] Check SimpleCov report
- [ ] Address any untested code
- [ ] Run performance tests
- [ ] Test accessibility compliance

### Documentation
- [ ] Update README with setup instructions
- [ ] Document API endpoints
- [ ] Create user documentation
- [ ] Document deployment process
- [ ] Add development guidelines

### Deployment
- [ ] Configure production environment
- [ ] Set up database backups
- [ ] Configure SSL
- [ ] Set up monitoring
- [ ] Deploy to Heroku
- [ ] Run post-deployment tests
- [ ] Verify all features in production
