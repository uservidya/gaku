class Translations < ActiveRecord::Migration

  def up
    create_table :gaku_attendance_types do |t|
      t.string   :name
      t.string   :color_code
      t.boolean  :counted_absent
      t.boolean  :disable_credit
      t.float    :credit_rate
      t.boolean  :auto_credit
      t.timestamps
    end
    Gaku::AttendanceType.create_translation_table! name: :string
    add_index :gaku_attendance_types, :name, unique: true


    create_table :gaku_commute_method_types do |t|
      t.string   :name
      t.timestamps
    end
    Gaku::CommuteMethodType.create_translation_table! name: :string
    add_index :gaku_commute_method_types, :name, unique: true


    create_table :gaku_enrollment_statuses do |t|
      t.string   :code
      t.string   :name
      t.boolean  :active
      t.boolean  :immutable
      t.timestamps
    end
    Gaku::EnrollmentStatus.create_translation_table! name: :string
    add_index :gaku_enrollment_statuses, :code, unique: true
    add_index :gaku_enrollment_statuses, :active


    create_table :gaku_scholarship_statuses do |t|
      t.string   :name
      t.boolean  :default
      t.timestamps
    end
    Gaku::ScholarshipStatus.create_translation_table! name: :string
    add_index :gaku_scholarship_statuses, :name, unique: true


    create_table :gaku_departments do |t|
      t.string   :name
      t.timestamps
    end
    Gaku::Department.create_translation_table! name: :string
    add_index :gaku_departments, :name, unique: true
  end

  def down
    drop_table :gaku_attendance_types
    Gaku::AttendanceType.drop_translation_table!
    remove_index :gaku_attendance_types, :name

    drop_table :gaku_commute_method_types
    Gaku::CommuteMethodType.drop_translation_table!
    remove_index :gaku_commute_method_types, :name

    drop_table :gaku_enrollment_statuses
    Gaku::EnrollmentStatus.drop_translation_table!
    remove_index :gaku_enrollment_statuses, :code
    remove_index :gaku_enrollment_statuses, :active

    drop_table :gaku_scholarship_statuses
    Gaku::ScholarshipStatus.drop_translation_table!
    remove_index :gaku_scholarship_statuses, :name

    drop_table :gaku_departments
    Gaku::Department.drop_translation_table!
    remove_index :gaku_departments, :name
  end

end
