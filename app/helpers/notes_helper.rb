module NotesHelper
   def note_permalink_path(note)
      year = note.published_at.year
      ordinal_day = note.published_at.yday
      "/#{year}/#{ordinal_day}/t/#{note.published_at.strftime('%H%M%S')}"
   end
end
