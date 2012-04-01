module SuperPacMan
  QUERIES = {
    :ward_crime_hash => "
      select ward, count(*) crime_count
      from crimes
      where
        date_part('year', occurred_at) = :year and
        trim(ward) != ''
      group by ward
      order by ward::integer;".strip
  }
end
