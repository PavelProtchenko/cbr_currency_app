module Currencies
  class List
    def self.call
      ActiveRecord::Base.connection.execute(<<-SQL)
        SELECT
          date,
          MAX(CASE WHEN char_code = 'EUR' THEN value END) AS euro,
          MAX(CASE WHEN char_code = 'USD' THEN value END) AS dollar
        FROM currencies
        WHERE char_code IN ('EUR', 'USD')
        GROUP BY date
        ORDER BY date
      SQL
    end
  end
end
