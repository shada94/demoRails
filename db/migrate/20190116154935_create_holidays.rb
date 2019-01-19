class CreateHolidays < ActiveRecord::Migration[5.0]
  def change
    create_table :holidays do |t|
      t.date :dateStart
      t.date :dateEnd
      t.string :reason
      t.string :state , default:'waitlisted'
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
