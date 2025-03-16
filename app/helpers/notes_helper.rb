module NotesHelper
  def note_permalink_path(note)
    return '#' unless note.published_at
    
    year = note.published_at.year
    ordinal_day = note.published_at.yday
    time = note.published_at.strftime('%H%M%S')
    
    notes_permalink_path(year: year, ordinal_day: ordinal_day, time: time)
  end
end
