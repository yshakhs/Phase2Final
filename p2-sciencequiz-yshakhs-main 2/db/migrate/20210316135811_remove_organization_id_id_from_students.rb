class RemoveOrganizationIdIdFromStudents < ActiveRecord::Migration[5.2]
  def change
    remove_column :students, :organization_id_id, :integer
  end
end
