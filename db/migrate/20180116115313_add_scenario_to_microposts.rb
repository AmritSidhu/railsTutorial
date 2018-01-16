class AddScenarioToMicroposts < ActiveRecord::Migration[5.1]
  def change
    add_column :microposts, :scenario, :string
  end
end
