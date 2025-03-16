# IndieWeb Personal Website Implementation Plan - All Prompts

Below is a comprehensive document containing all prompts for implementing the IndieWeb personal website project.

## Phase 1: Foundation Setup

### Prompt 1: Project Initialization

```
Create a new Ruby on Rails application with the following specifications:
- Rails 7.0+ with PostgreSQL database
- RSpec for testing
- SimpleCov for test coverage
- Configured for Heroku deployment
- Basic project structure focusing on service objects

The application should implement:
1. Application layout with proper doctype and meta tags
2. Database configuration for development, test, and production
3. RSpec configuration with FactoryBot and Shoulda Matchers
4. SimpleCov setup with appropriate test coverage metrics
5. Initial .gitignore and README.md files
6. Gemfile with necessary gems including:
   - rspec-rails
   - factory_bot_rails
   - shoulda-matchers
   - simplecov
   - redcarpet for Markdown
   - faker for test data
   - dotenv for environment variables

Ensure the application follows the principles of:
- Service objects for business logic
- Thin controllers and models
- TDD approach with comprehensive test coverage

Implement a home controller with a simple index page as a starting point, with appropriate specs.
```

### Prompt 2: Authentication Foundation

```
Building on the existing Rails application, implement a basic authentication system with the following features:
1. User model with email, password_digest, name, and admin fields
2. Secure password using has_secure_password
3. User validations for email uniqueness and password complexity
4. Sessions controller for login/logout functionality
5. Current user helper method
6. Authorization concern for admin access control

Implement the following components using TDD:
1. User model with appropriate specs
2. Sessions controller with proper authentication tests
3. Authentication service object for login logic
4. Admin authorization checks
5. User factory for testing
6. Helper methods for current_user access in views and controllers

Ensure all controllers inherit authentication behavior appropriately and tests verify proper access control. Make sure the login form and logout functionality work properly with appropriate redirects and flash messages.
```

### Prompt 3: Media Attachments Support

```
Extend the Rails application to support media attachments with the following components:
1. Configure Active Storage for file uploads
2. Create a MediaAttachment model with:
   - Polymorphic association (attachable)
   - Caption field
   - File attachment using Active Storage
   - Created_at and updated_at timestamps
3. Implement validations for file types (images, videos, audio)
4. Create a media upload service object for handling attachments

Implement TDD approach for:
1. MediaAttachment model specs including validations and associations
2. Media upload service specs with proper mocking of file uploads
3. Controller concern for handling media attachments
4. Factory for media attachments
5. Validation service to check file types and sizes

Ensure the system properly validates and stores file attachments with appropriate error handling. Implement appropriate database migrations and indices for the polymorphic relationship.
```

## Phase 2: Core Models & Data Structure

### Prompt 4: Base Content Models

```
Implement the base content models with shared behavior using TDD:
1. Create a Content concern module with:
   - Shared validation methods
   - Slug generation functionality
   - Published status management
   - Syndication URLs handling (serialized array)
   - Timestamps handling

2. Create the Note model:
   - Include Content concern
   - Body field (text)
   - Published_at field (datetime)
   - Slug field (string)
   - Syndication_urls field (text)
   - Has_many relationship with MediaAttachments (polymorphic)

3. Create the Article model:
   - Include Content concern
   - Title field (string)
   - Body field (text)
   - Published_at field (datetime)
   - Slug field (string)
   - Syndication_urls field (text)
   - Has_many relationship with MediaAttachments (polymorphic)

4. Implement a slug generation service that:
   - Creates unique slugs for content
   - Handles special characters
   - Ensures URL-friendly format

Write comprehensive tests covering:
1. Model validations
2. Content concern shared behavior
3. Slug generation edge cases
4. Serialization of syndication_urls
5. Associations with MediaAttachments

Ensure all database migrations, indices, and model relationships are properly configured.
```

### Prompt 5: Specialized Content Models

```
Building on the base content models, implement the specialized content types with TDD:
1. Create the MovieReview model:
   - Include Content concern
   - Title field (string)
   - Year field (integer)
   - Quality_rating field (integer)
   - Performance_rating field (integer)
   - Story_rating field (integer)
   - Enjoyment_rating field (integer)
   - Total_rating field (integer, computed)
   - Body field (text)
   - Published_at, slug, syndication_urls fields

2. Create the Listen model:
   - Track_name field (string)
   - Artist field (string)
   - Album field (string, optional)
   - Listened_at field (datetime)
   - Source_url field (string)

3. Create the Talk model:
   - Include Content concern
   - Title field (string)
   - Body field (text)
   - Event_name field (string)
   - Event_date field (date)
   - Slides_url field (string, optional)
   - Recording_url field (string, optional)
   - Published_at, slug, syndication_urls fields

Implement the following:
1. Rating calculation service for MovieReview
2. Validations for all models
3. Factories for testing each model
4. Shared specs for common content behavior
5. Specific specs for model-unique behavior

Ensure all database migrations are set up correctly with appropriate indices and constraints.
```

### Prompt 6: Unified Activity Model

```
Implement a unified Activity model to create a timeline of all content:
1. Create the Activity model with:
   - Trackable_id field (integer)
   - Trackable_type field (string)
   - Created_at timestamp
   - Polymorphic association named 'trackable'

2. Implement callbacks in each content model:
   - After_create callback to generate an activity
   - After_destroy callback to remove associated activity

3. Create an ActivityCreationService:
   - Handles creating activities for different content types
   - Ensures proper polymorphic associations
   - Handles edge cases and validation

Write comprehensive tests for:
1. Activity model validations and associations
2. Callback behavior in content models
3. ActivityCreationService functionality
4. Query performance for activity retrieval
5. Factory for activities in tests

Ensure activities are properly created, associated, and can be queried efficiently. Implement appropriate database indices for the polymorphic relationship.
```

## Phase 3: Content Type Implementation

### Prompt 7: Notes Implementation

```
Implement the Notes functionality using TDD:
1. Create a NotesController with:
   - Index action for listing notes
   - Show action for displaying a single note
   - New and create actions for note creation
   - Edit and update actions for editing notes
   - Destroy action for deleting notes
   - Proper authorization checks

2. Create a CreateNoteService:
   - Handles note creation logic
   - Manages transactions
   - Handles media attachments
   - Returns appropriate responses

3. Implement a markdown parsing service:
   - Converts markdown to HTML
   - Handles various markdown syntax
   - Ensures proper sanitization

4. Create views for notes:
   - Index view with note list
   - Show view with formatted content
   - Form partial for creation/editing
   - Media attachment handling

Write comprehensive tests for:
1. Controller actions and authentication
2. Service object functionality
3. View rendering and data presentation
4. Form submission and validation

Ensure proper permalinks are generated based on slugs and implement appropriate routes.
```

### Prompt 8: Articles Implementation

```
Building on the Notes implementation, create the Articles functionality:
1. Create an ArticlesController with:
   - Index action for listing articles
   - Show action for displaying a single article
   - New and create actions for article creation
   - Edit and update actions for editing articles
   - Destroy action for deleting articles
   - Proper authorization checks

2. Create a CreateArticleService:
   - Handles article creation logic
   - Manages transactions
   - Handles media attachments
   - Returns appropriate responses

3. Create views for articles:
   - Index view with article list and titles
   - Show view with formatted content and title
   - Form partial for creation/editing
   - Media attachment handling

4. Implement enhanced markdown parsing for articles:
   - Support for additional formatting
   - Handling of headings, blockquotes
   - Proper sanitization

Write comprehensive tests for:
1. Controller actions and authentication
2. Service object functionality
3. View rendering and data presentation
4. Form submission and validation

Ensure proper permalinks are generated based on slugs and implement appropriate routes.
```

### Prompt 9: Movie Reviews Implementation

```
Implement the Movie Reviews functionality with TDD:
1. Create a MovieReviewsController with:
   - Index action for listing reviews
   - Show action for displaying a single review
   - New and create actions for review creation
   - Edit and update actions for editing reviews
   - Destroy action for deleting reviews
   - Proper authorization checks

2. Create a CreateMovieReviewService:
   - Handles review creation logic
   - Calculates total rating
   - Manages transactions
   - Returns appropriate responses

3. Implement a RatingCalculationService:
   - Calculates total rating from individual criteria
   - Validates rating inputs
   - Formats ratings for display

4. Create views for movie reviews:
   - Index view with review list
   - Show view with formatted content and ratings
   - Form partial with rating inputs
   - Movie metadata display

Write comprehensive tests for:
1. Controller actions and authentication
2. Service object functionality
3. Rating calculation
4. View rendering and data presentation
5. Form submission and validation

Ensure proper permalinks are generated based on slugs and implement appropriate routes.
```

### Prompt 10: Listens Implementation

```
Implement the music listening activity functionality:
1. Create a LastfmApiClient:
   - Handles API communication
   - Fetches recent tracks
   - Processes API responses
   - Handles error cases

2. Create a ListenImportService:
   - Uses the LastfmApiClient
   - Processes track data
   - Creates or updates Listen records
   - Handles deduplication

3. Create a background job for importing:
   - Scheduled import task
   - Error handling and retries
   - Logging of import activity

4. Create a ListensController:
   - Index action for listing listens
   - Show action for single listen
   - Manual import action (admin only)

5. Create views for listens:
   - Index view with listening activity
   - Show view for individual listen
   - Statistics/summary view

Write comprehensive tests for:
1. API client with stubbed responses
2. Import service functionality
3. Background job behavior
4. Controller actions
5. View rendering

Implement appropriate routes and ensure proper data display with relevant timestamps.
```

### Prompt 11: Talks Implementation

```
Implement the Talks functionality with TDD:
1. Create a TalksController with:
   - Index action for listing talks
   - Show action for displaying a single talk
   - New and create actions for talk creation
   - Edit and update actions for editing talks
   - Destroy action for deleting talks
   - Proper authorization checks

2. Create a CreateTalkService:
   - Handles talk creation logic
   - Manages transactions
   - Validates URLs for slides/recordings
   - Returns appropriate responses

3. Create views for talks:
   - Index view with talk list
   - Show view with formatted content and event details
   - Form partial with metadata fields
   - Links to slides and recordings

4. Implement URL validation service:
   - Validates existence of external resources
   - Checks for valid URL format
   - Handles timeout and error cases

Write comprehensive tests for:
1. Controller actions and authentication
2. Service object functionality
3. URL validation
4. View rendering and data presentation
5. Form submission and validation

Ensure proper permalinks are generated based on slugs and implement appropriate routes.
```

## Phase 4: IndieWeb Features

### Prompt 12: Microformats Implementation

```
Implement IndieWeb microformats across the site:
1. Create a HCard helper:
   - Generates h-card markup for the profile
   - Includes name, photo, URL, and other profile data
   - Follows microformats2 specification

2. Create HEntry helpers:
   - Generates h-entry markup for content types
   - Handles author, published date, content
   - Supports specific content type attributes
   - Follows microformats2 specification

3. Create view partials:
   - Profile partial with h-card
   - Content partials with h-entry
   - Specialized partials for each content type

4. Implement MicroformatService:
   - Validates microformat structure
   - Provides utility methods for generation
   - Handles edge cases and special formatting

Write comprehensive tests for:
1. Helper methods output
2. Microformat structure validation
3. Rendering of microformatted content
4. Edge cases handling

Ensure all content views incorporate appropriate microformats and validate against the microformats2 spec.
```

### Prompt 13: Webmentions - Receiving

```
Implement webmention receiving functionality:
1. Create a Webmention model:
   - Source field (string, URL of the mentioning site)
   - Target field (string, URL of the mentioned content)
   - Verified field (boolean)
   - Payload field (text, serialized JSON)
   - Mentioned_type and mentioned_id fields (polymorphic)
   - Created_at and updated_at timestamps

2. Create a WebmentionsController:
   - Endpoint action for receiving webmentions
   - Verification of source and target
   - Queue processing job
   - Return appropriate status codes

3. Implement a WebmentionVerificationService:
   - Fetches the source URL
   - Verifies link to target exists
   - Extracts and processes mention data
   - Handles different webmention types

4. Create a WebmentionProcessingJob:
   - Background processing of received webmentions
   - Verification and storage
   - Association with mentioned content
   - Error handling and logging

5. Create view partials for displaying webmentions:
   - List of webmentions on content
   - Individual webmention display
   - Types of webmentions (likes, reposts, replies)

Write comprehensive tests for:
1. Model validations and associations
2. Controller endpoint functionality
3. Verification service with stubbed HTTP requests
4. Job processing behavior
5. View rendering

Ensure proper database migrations with indices and implement appropriate routes.
```

### Prompt 14: Webmentions - Sending

```
Implement webmention sending functionality:
1. Create a WebmentionDiscoveryService:
   - Extracts links from content
   - Discovers webmention endpoints
   - Handles different endpoint types
   - Returns discovered endpoints

2. Create a WebmentionSendingService:
   - Sends webmentions to endpoints
   - Handles HTTP responses
   - Tracks success/failure
   - Returns results

3. Create a WebmentionSendingJob:
   - Background processing for sending
   - Handles retries and failures
   - Logs activities
   - Updates content with syndication URLs when applicable

4. Implement callbacks in content models:
   - After_save callback to queue webmention sending
   - Handles both new content and updates

Write comprehensive tests for:
1. Discovery service with stubbed HTML responses
2. Sending service with mocked HTTP requests
3. Job behavior and retry logic
4. Callback functionality in models

Ensure the system properly tracks and reports on sent webmentions.
```

### Prompt 15: IndieAuth Implementation

```
Implement IndieAuth functionality:
1. Create an AuthorizationController:
   - Authorization endpoint action
   - Token endpoint action
   - Verification of client
   - Handling of auth request params

2. Create a TokenService:
   - Generates secure tokens
   - Validates token requests
   - Handles token storage
   - Manages token expiration

3. Create a ClientVerificationService:
   - Validates redirect URLs
   - Verifies client identity
   - Handles client registration
   - Manages client permissions

4. Implement necessary views:
   - Authorization confirmation page
   - Error pages for auth failures
   - Success pages

5. Add necessary authorization headers and links:
   - Authorization endpoint link in header
   - Token endpoint link in header
   - Proper link relations

Write comprehensive tests for:
1. Controller endpoints
2. Token generation and validation
3. Client verification
4. View rendering
5. Header inclusion

Ensure the implementation follows the IndieAuth specification and handles all required parameters and flows.
```

## Phase 5: Integration & Syndication

### Prompt 16: Mastodon Integration

```
Implement Mastodon integration for POSSE syndication:
1. Create a MastodonApiClient:
   - Handles authentication
   - Creates posts
   - Uploads media
   - Processes responses

2. Create a MastodonSyndicationService:
   - Uses the API client
   - Formats content for Mastodon
   - Handles character limits
   - Processes media attachments
   - Returns syndication URLs

3. Create a MastodonSyndicationJob:
   - Background processing of syndication
   - Error handling and retries
   - Updates content with syndication URLs
   - Logs syndication activity

4. Implement configuration for Mastodon:
   - Environment variables for API access
   - Instance URL configuration
   - Authentication tokens storage
   - User preferences for syndication

Write comprehensive tests for:
1. API client with stubbed responses
2. Syndication service functionality
3. Job behavior and retry logic
4. Content formatting

Ensure proper error handling for API rate limits and failures.
```

### Prompt 17: LinkedIn Integration

```
Implement LinkedIn integration for POSSE syndication:
1. Create a LinkedInApiClient:
   - Handles OAuth authentication
   - Creates posts
   - Uploads media
   - Processes responses

2. Create a LinkedInSyndicationService:
   - Uses the API client
   - Formats content for LinkedIn
   - Processes media attachments
   - Returns syndication URLs
   - Handles different content types

3. Create a LinkedInSyndicationJob:
   - Background processing of syndication
   - Error handling and retries
   - Updates content with syndication URLs
   - Logs syndication activity

4. Implement configuration for LinkedIn:
   - Environment variables for API access
   - OAuth token management
   - Authentication flow
   - User preferences for syndication

Write comprehensive tests for:
1. API client with stubbed responses
2. Syndication service functionality
3. Job behavior and retry logic
4. Content formatting
5. OAuth flow

Ensure proper error handling for API rate limits and failures.
```

### Prompt 18: Syndication Management

```
Implement a unified syndication management system:
1. Create a SyndicationManager service:
   - Coordinates different syndication services
   - Applies content-specific rules
   - Handles success/failure across platforms
   - Updates content with syndication URLs

2. Create a SyndicationQueueService:
   - Manages queuing of content for syndication
   - Handles priorities
   - Manages retries
   - Tracks syndication status

3. Implement syndication UI components:
   - Syndication toggles in content forms
   - Syndication status display
   - Manual syndication triggers
   - Syndication error reporting

4. Create a SyndicationReportingService:
   - Tracks syndication performance
   - Identifies recurring failures
   - Provides status summaries
   - Helps debug issues

Write comprehensive tests for:
1. Manager service coordination
2. Queue service functionality
3. UI components
4. Reporting accuracy

Ensure proper integration with all content types and syndication targets.
```

## Phase 6: UI & Activity Feed

### Prompt 19: Homepage Implementation

```
Implement the homepage with profile and content:
1. Create a HomeController:
   - Index action for homepage
   - Profile data loading
   - Latest content aggregation

2. Create a ProfileService:
   - Loads user profile data
   - Formats h-card information
   - Handles social links
   - Manages profile photo

3. Create a LatestContentService:
   - Aggregates recent content by type
   - Optimizes queries
   - Handles pagination
   - Formats for display

4. Implement homepage views:
   - Profile section with h-card
   - Content type navigation
   - Latest content feed
   - Responsive layout

5. Add proper meta tags and SEO:
   - Open Graph tags
   - Twitter card tags
   - Description and title
   - Canonical URLs

Write comprehensive tests for:
1. Controller actions
2. Service functionality
3. View rendering
4. Content aggregation
5. SEO tag presence

Ensure the homepage is fully responsive and showcases the site's content effectively.
```

### Prompt 20: Activity Feed

```
Implement a unified activity feed:
1. Create an ActivitiesController:
   - Index action for timeline
   - Filtering by content type
   - Pagination
   - Format handling (HTML, JSON)

2. Create an ActivityTimelineService:
   - Queries Activities with their trackable content
   - Optimizes database loading
   - Handles filtering and sorting
   - Manages pagination

3. Implement view components:
   - Activity stream with polymorphic rendering
   - Content type-specific partials
   - Pagination controls
   - Infinite scroll functionality

4. Create ActivityPresenter:
   - Handles polymorphic presentation
   - Formats dates consistently
   - Provides context-specific rendering
   - Manages content preview

Write comprehensive tests for:
1. Controller actions
2. Service query performance
3. Presenter functionality
4. View rendering
5. Pagination behavior

Ensure the feed loads efficiently and displays all content types appropriately.
```

### Prompt 21: Responsive Design

```
Implement responsive design and final UI polish:
1. Apply custom CSS framework:
   - Base typography styles
   - Layout components
   - Color scheme
   - UI elements

2. Create responsive components:
   - Mobile navigation menu
   - Responsive media handling
   - Flexible layouts
   - Breakpoint-specific styles

3. Implement content-specific design:
   - Note card design
   - Article layout
   - Movie review presentation
   - Listen activity display
   - Talk information layout

4. Add accessibility enhancements:
   - Proper ARIA attributes
   - Keyboard navigation
   - Screen reader compatibility
   - Color contrast compliance

5. Implement print styles:
   - Printer-friendly layouts
   - Proper page breaks
   - Resource-saving formatting

Write comprehensive tests for:
1. Responsive behavior
2. Component rendering
3. Accessibility compliance
4. Print output

Ensure the site is fully responsive across all device sizes and content types.
```