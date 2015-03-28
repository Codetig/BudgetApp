class ChangeUsers < ActiveRecord::Migration
  def change
    #making the email field match the devise specs
    change_table :users do |t|
      t.remove :email
      t.string :email, null: false, default: ""
    end
  end
end
