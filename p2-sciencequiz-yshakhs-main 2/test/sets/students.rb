module Contexts
    module Students

        def create_students
            @student1 = FactoryBot.create(:student, organization: @tamu) #default student
            @student2 = FactoryBot.create(:student, first_name: "Maha", last_name: "Al-zeyara", grade: 8,organization: @cmu ,  active: true )
            @student3 = FactoryBot.create(:student, first_name: "Khawla", last_name: "Al-maadeed", grade: 9, organization: @cmu ,  active: false )
        end
        
        def destroy_students
            @student1.destroy #destoy student record
            @student2.destroy
            @student3.destroy
        end

    end
end