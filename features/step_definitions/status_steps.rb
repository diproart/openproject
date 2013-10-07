#-- copyright
# OpenProject is a project management system.
# Copyright (C) 2012-2013 the OpenProject Foundation (OPF)
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License version 3.
#
# OpenProject is a fork of ChiliProject, which is a fork of Redmine. The copyright follows:
# Copyright (C) 2006-2013 Jean-Philippe Lang
# Copyright (C) 2010-2013 the ChiliProject Team
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
#
# See doc/COPYRIGHT.rdoc for more details.
#++

Given /^there is a(?:n)? (default )?(?:issue)?status with:$/ do |default, table|
  name = table.raw.select { |ary| ary.include? "name" }.first[table.raw.first.index("name") + 1].to_s
  Status.find_by_name(name) || Status.create(:name => name.to_s, :is_default => !!default)
end

Given /^there are the following status:$/ do |table|
  table.hashes.each do |row|
    attributes = row.inject({}) { |mem, (k, v)| mem[k.to_sym] = v if v.present?; mem }
    attributes[:is_default] = attributes.delete(:default) == "true"

    FactoryGirl.create(:status, attributes)
  end
end

InstanceFinder.register(Status, Proc.new { |name| Status.find_by_name(name) })
