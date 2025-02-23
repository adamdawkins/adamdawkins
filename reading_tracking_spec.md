# Reading Tracking System Specification

## Overview
This document outlines the specifications for a reading tracking feature on adamdawkins.com. The system will allow the user to track their reading progress, log percentage completion updates over time, and categorize books by reading status (to-read, currently reading, finished, paused, abandoned). The feature will include a one-time import from StoryGraph and will be primarily managed through a private section of the site.

## Functional Requirements

### 1. Core Features
- **Track books with percentage completion**
  - Books have a percentage field that logs progress over time.
  - Each progress update is stored with a timestamp.
- **Track reading statuses:**
  - To-read
  - Currently reading
  - Finished
  - Paused
  - Abandoned
- **Mark books as finished manually**
  - Setting a book to 'finished' automatically updates progress to 100%.
- **Separate tracking for paused and abandoned books**
  - Paused books remain visible in a 'Paused' section.
  - Abandoned books remain visible in an 'Abandoned' section.
- **Resume paused books with previous progress intact**
- **Resume abandoned books by moving them back to 'Currently Reading'**
- **Store metadata**
  - Title, author, and cover image (retrieved via ISBN lookup when possible)
  - ISBN as a natural UUID
  - Date started, date finished, date of each progress update
  - Date a book was paused or abandoned
- **Bulk update past reads**
  - Mark books as finished with a manually specified date.
- **StoryGraph Import**
  - One-time import from StoryGraph.
  - Automatically match books via ISBN.
  - Manually resolve unmatched books.
  - Import all reading statuses.
  - Include progress history for currently reading books.
  - Implemented as a rake task.

### 2. UI & Display Requirements
- **Private area for updating progress**
  - Users manually update progress and status.
- **Public 'Reading' section**
  - Displays:
    - 'Currently Reading' books prominently
    - 'Recently Read' books (books finished this calendar month)
- **Sort books by most recent update**
- **Simple list-based UI (no visualizations for now)**

## Architecture & Data Model

### 1. Database Schema
#### Books Table
| Column         | Type       | Notes |
|---------------|-----------|-------|
| id            | UUID      | Primary key |
| title         | String    |  |
| author        | String    |  |
| cover_url     | String    | External cover image URL |
| isbn          | String    | Natural UUID, nullable for manual entries |
| status        | Enum      | To-read, Currently Reading, Finished, Paused, Abandoned |
| date_started  | Date      | Nullable |
| date_finished | Date      | Nullable |
| date_paused   | Date      | Nullable |
| date_abandoned | Date     | Nullable |
| created_at    | Timestamp |  |
| updated_at    | Timestamp |  |

#### Progress Updates Table
| Column         | Type       | Notes |
|---------------|-----------|-------|
| id            | UUID      | Primary key |
| book_id       | UUID      | Foreign key to books table |
| percentage    | Integer   | 0-100 |
| updated_at    | Timestamp |  |

### 2. System Architecture
- **Rails backend** for storing book and progress data.
- **Simple UI** for managing books in the private area.
- **Public API or page rendering for the 'Reading' section.**
- **StoryGraph import implemented as a rake task.**

## Data Handling & Error Handling

### 1. Data Validation
- Ensure percentage values are between 0 and 100.
- Ensure ISBN values (if present) are valid.
- Prevent duplicate progress updates within a short timeframe.

### 2. Error Handling
- **Book creation:**
  - If ISBN lookup fails, allow manual entry.
- **Progress updates:**
  - Reject updates where the percentage is lower than the last logged progress.
- **StoryGraph import:**
  - Log failures for books that can’t be matched.
  - Allow manual resolution for unmatched books.

## Testing Plan

### 1. Unit Tests
- Validate book creation with and without ISBN lookup.
- Ensure progress updates are stored correctly with timestamps.
- Test manual marking of books as finished.

### 2. Integration Tests
- Test StoryGraph import with auto-matching and manual resolution.
- Verify UI displays books correctly in private and public sections.
- Ensure reading status transitions work as expected.

### 3. Edge Cases
- Marking a book as finished without a start date.
- Handling books that move from paused to abandoned and back.
- Books that are abandoned early vs. nearly finished.
- Importing a book from StoryGraph that already exists.

## Next Steps
- Implement database migrations.
- Build API endpoints and UI for book management.
- Develop StoryGraph import rake task.
- Test system iteratively with real data.

---
This specification provides everything needed for development. Let me know if you'd like any adjustments!

