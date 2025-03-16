# IndieWeb Personal Website Specification

## Overview
This specification outlines the requirements for a personal website that embraces IndieWeb principles, enabling the owner to maintain ownership of their content while syndicating to other platforms. The site will serve as a central hub for various content types including short-form notes, long-form articles, movie reviews, music listening activity, and professional talks.

## Technology Stack
- **Framework**: Ruby on Rails
- **Hosting**: Heroku
- **Content Format**: Markdown for all content types
- **Authentication**: IndieAuth (self-implemented)
- **CSS**: Custom minimal stylesheet (already developed)

## Core Principles
- Test-Driven Development using RSpec
- Small, incremental commits
- Service objects for domain logic
- Thin controllers focused on data loading and redirection
- Models as database wrappers
- Adherence to IndieWeb standards and microformats

## Content Types

### Notes
- Short, unstructured text content without titles
- Support for markdown formatting
- Support for media attachments (images, videos, audio)
- Permalink for each note
- Implementation of h-entry microformat
- POSSE syndication to Mastodon

### Articles
- Structured content with titles
- Support for paragraphs, subheadings, blockquotes
- Support for embedded media
- Implementation of h-entry microformat
- POSSE syndication to LinkedIn and Mastodon

### Movie Reviews
- Separate content type from notes/articles
- Movie metadata: title and year
- Four rating criteria:
  - Quality
  - Performance
  - Story
  - Enjoyment
- Each criterion rated out of 5 for a total score out of 20
- Implementation of appropriate microformats

### Music Listens
- Separate content type
- Data imported from Last.fm
- Implementation of appropriate microformats for listen activities

### Talks
- Structured like articles
- Support for embedded URLs to slides/recordings
- Implementation of appropriate microformats

## Features

### Activity Feed
- Chronological display of all content types
- Unified polymorphic "Activity" model referencing all content types
- Timeline-style presentation

### Homepage
- Display of latest content
- Profile information with h-card microformat
- Links to different content type sections

### Responsive Design
- Full support for mobile, tablet, and desktop viewing
- Based on existing CSS foundation
- Minimal, typography-focused design

### Webmentions
- Self-implemented webmention endpoint
- Support for both sending and receiving webmentions
- Display of received webmentions on content pages

### POSSE (Publish on Own Site, Syndicate Elsewhere)
- Integration with LinkedIn API
- Integration with Mastodon API
- Content-specific syndication rules
- Support for retrieving and displaying syndication links

### IndieWeb Compatibility
- Implementation of h-card for profile
- Implementation of h-entry for content
- Implementation of other relevant microformats
- Self-implemented IndieAuth

### Privacy-Focused Analytics
- Minimal tracking of visitor data
- No third-party analytics services

## Data Models

### Note
- `body`: text
- `published_at`: datetime
- `slug`: string
- `syndication_urls`: text (serialized array)
- `media_attachments`: has_many relationship

### Article
- `title`: string
- `body`: text
- `published_at`: datetime
- `slug`: string
- `syndication_urls`: text (serialized array)
- `media_attachments`: has_many relationship

### MovieReview
- `title`: string
- `year`: integer
- `quality_rating`: integer
- `performance_rating`: integer
- `story_rating`: integer
- `enjoyment_rating`: integer
- `total_rating`: integer (computed)
- `body`: text
- `published_at`: datetime
- `slug`: string

### Listen
- `track_name`: string
- `artist`: string
- `album`: string (optional)
- `listened_at`: datetime
- `source_url`: string (Last.fm URL)

### Talk
- `title`: string
- `body`: text
- `event_name`: string
- `event_date`: date
- `slides_url`: string (optional)
- `recording_url`: string (optional)
- `published_at`: datetime
- `slug`: string

### Activity
- `trackable_id`: integer
- `trackable_type`: string (polymorphic reference)
- `created_at`: datetime

### MediaAttachment
- `file`: active_storage attachment
- `caption`: string (optional)
- `attachable_id`: integer
- `attachable_type`: string (polymorphic reference)

### Webmention
- `source`: string (URL of the mentioning site)
- `target`: string (URL of the mentioned content)
- `verified`: boolean
- `payload`: text (serialized JSON)
- `mentioned_type`: string (polymorphic reference)
- `mentioned_id`: integer

## Error Handling

### Content Creation/Update Failures
- Validation errors displayed to the user
- Auto-saving of drafts to prevent data loss

### API Integration Failures
- Graceful degradation when POSSE syndication fails
- Background job retries for failed syndications
- Error logging for debugging

### Webmention Processing
- Validation of incoming webmentions
- Rate limiting to prevent abuse
- Rejection of invalid or malicious webmentions

## Testing Plan

### Unit Tests
- Model validations
- Service objects
- Helper methods

### Integration Tests
- Content creation workflows
- Webmention sending/receiving
- POSSE syndication

### System Tests
- End-to-end content workflows
- Responsive design testing
- IndieWeb compatibility

### Test Coverage
- Aim for high test coverage (90%+)
- Focus on critical paths and complex logic

## Development Approach
- Test-driven development using RSpec
- Small, incremental commits
- Services for domain logic
- Thin controllers
- Models as database wrappers

## Deployment Strategy
- Continuous integration with automated testing
- Deployment to Heroku
- Utilize Heroku's built-in backup functionality

## Future Considerations (Not Implemented Initially)
- Search functionality
- Advanced filtering
- Performance optimizations (caching, CDN)
- Additional syndication targets

## Timeline
- Phase 1: Core infrastructure and content types
- Phase 2: IndieWeb features (microformats, webmentions)
- Phase 3: POSSE implementation
- Phase 4: Activity feed and UI refinements