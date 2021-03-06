require 'spec_helper'

describe 'ClassGroups' do

  before { as :admin }
  before(:all) { set_resource('class-group') }

  let(:class_group) do
    create(:class_group, grade: '1',
                         name: 'Not so awesome class group',
                         homeroom: 'A1')
  end

  let(:class_group_with_semesters) { create(:class_group, :with_semesters) }

  context 'new', js: true do
    before do
      visit gaku.class_groups_path
      click new_link
    end

    it 'creates and shows', js: true do
      expect do
        fill_in 'class_group_grade',    with: '7'
        fill_in 'class_group_name',     with: 'Awesome class group'
        fill_in 'class_group_homeroom', with: 'room#7'
        click submit
        flash_created?
      end.to change(Gaku::ClassGroup, :count).by 1

      click '#class-groups-without-semester-tab-link'

      has_content? '7'
      has_content? 'Awesome class group'
      has_content? 'room#7'

      count? 'Class Groups list(1)'
    end

    it { has_validations? }
  end

  context 'existing', js: true do
    before do
      class_group_with_semesters
      visit gaku.class_groups_path
    end

    context 'edit' do

      context 'from edit view' do
        before do
          visit gaku.edit_class_group_path(class_group_with_semesters)
        end

        it 'edits' do
          fill_in 'class_group_grade',    with: '2'
          fill_in 'class_group_name',     with: 'Really awesome class group'
          fill_in 'class_group_homeroom', with: 'B2'

          click submit
          flash_updated?

          expect(find_field('class_group_name').value).to eq 'Really awesome class group'
          expect(find_field('class_group_grade').value).to eq '2'
          expect(find_field('class_group_homeroom').value).to eq 'B2'

          class_group_with_semesters.reload
          expect(class_group_with_semesters.name).to eq 'Really awesome class group'
          expect(class_group_with_semesters.grade).to eq 2
          expect(class_group_with_semesters.homeroom).to eq 'B2'
        end

        it 'has validations' do
          fill_in 'class_group_name', with: ''
          has_validations?
        end
      end

    end

     it 'deletes' do
        visit gaku.edit_class_group_path(class_group)

        expect do
          click modal_delete_link
          within(modal) { click_on 'Delete' }
          accept_alert
          flash_destroyed?
        end.to change(Gaku::ClassGroup, :count).by -1

        current_path.should eq gaku.class_groups_path
      end

  end
end
