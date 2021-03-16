class RemoveOrganizationIdIdFromTeams < ActiveRecord::Migration[5.2]
  def change
    remove_column :teams, :organization_id_id, :integer
  end
end
