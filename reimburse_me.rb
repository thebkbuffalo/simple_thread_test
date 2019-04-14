require 'date'
require 'pry'

@sets = [
  [
    {project: 1, cost: 'low', sd: '9/1/15', ed: '9/1/15'}
  ],
  [
    {proj: 1, cost: 'low', sd: '9/1/15', ed: '9/1/15'},
    {proj: 2, cost: 'high', sd: '9/2/15', ed: '9/6/15'},
    {proj: 3, cost: 'low', sd: '9/6/15', ed: '9/8/15'}
  ],
  [
    {proj: 1, cost: 'low', sd: '9/1/15', ed: '9/3/15'},
    {proj: 2, cost: 'high', sd: '9/5/15', ed: '9/7/15'},
    {proj: 3, cost: 'high', sd: '9/8/15', ed: '9/8/15'}
  ],
  [
    {proj: 1, cost: 'low', sd: '9/1/15', ed: '9/1/15'},
    {porj: 2, cost: 'low', sd: '9/1/15', ed: '9/1/15'},
    {proj: 3, cost: 'high', sd: '9/2/15', ed: '9/2/15'},
    {proj: 4, cost: 'high', sd: '9/2/15', ed: '9/3/15'}
  ]
]

def get_reimbursment_breakdown(sets)
  @sets.each_with_index do |set, i|
    @proj_dates = arrayify_dates(set)
    @proj_costs = get_proj_cost(set)
    # @proj_breakdown = breakdown(@proj_dates, @proj_costs)
    puts 'Set ' + (i + 1).to_s
    puts @proj_dates
    puts @proj_costs
    puts '------------------------------------------------------------------------------------------------'
  end
end

# def get_dates_breakdown(sets)
#   @sets.each_with_index do |set, i|
#     case i
#     when 0
#       @proj_dates = arrayify_dates(set)
#       @proj_costs = get_proj_cost(set)
#       @proj_breakdown = breakdown(@proj_dates, @proj_costs)
#       puts "here will be answer per project"
#     when 1
#       @proj_dates = arrayify_dates(set)
#       @proj_costs = get_proj_cost(set)
#       @proj_breakdown = breakdown(@proj_dates, @proj_costs)
#     when 2
#       @proj_dates = arrayify_dates(set)
#       @proj_dates = get_proj_cost(set)
#       @proj_breakdown = breakdown(@proj_dates, @proj_costs)
#     when 3
#       @proj_dates = arrayify_dates(set)
#       @proj_dates = get_proj_cost(set)
#       @proj_breakdown = breakdown(@proj_dates, @proj_costs)
#     end
#   end
# end

def arrayify_dates(set)
  @all_dates = []
  set.each do |d|
    sd = Date.parse(d[:sd])
    ed = Date.parse(d[:ed])
    dates = [sd, ed]
    @all_dates.push(dates)
  end
  @all_dates
end

def get_proj_cost(set)
  @all_costs = []
  set.each do |s|
    @all_costs.push(s[:cost])
  end
  @all_costs
end

def breakdown(proj_dates, proj_costs)
  @low_travel_day = 45
  @high_travel_day = 55
  @low_full_day = 75
  @high_full_day = 85
  proj_dates.each_with_index do |dates, i|
    cost_level = proj_costs[i]
    sd = dates.first
    ed = dates.last
    if sd == ed
      # single day situation...not sure how that payment would work but once i do these shouldn't be hard
    else
      date_range = ed - sd
      binding.pry
    end
  end
end

get_reimbursment_breakdown(@sets)

# broader ambitions
# arg = ARGV[0]
#
# def get_set(arg)
#   case arg
#   when "set_1"
#     data = @sets.first
#   when "set_2"
#     data = @sets[1]
#   when "set_3"
#     data = @sets[2]
#   when "set_4"
#     data = @sets.last
#   when nil
#     data = @sets
#   end
#   data
# end
#
# @data = get_set(arg)
# puts @data
#
# puts '-----------------------------------------------------------------------'
#
# def get_dates(data)
#   if data.first.class == Array # for full data set
#     @dates_array = []
#     data.each_with_index do |proj, i|
#       proj_dates = arrayify_dates_full_set(proj, i)
#       @dates_array.push(proj_dates)
#     end
#   else # for individual data set
#     @dates_array = arrayify_dates(data)
#   end
#   @dates_array
# end
#
# def arrayify_dates(set)
#   @all_dates = []
#   set.each_with_index do |d, i|
#     sd = Date.parse(d[:sd])
#     ed = Date.parse(d[:ed])
#     dates = [sd, ed]
#     @all_dates.push(dates)
#   end
#   @all_dates
# end
#
# def arrayify_dates_full_set(set, i)
#   @all_dates = []
#   set.each do |d|
#     sd = Date.parse(d[:sd])
#     ed = Date.parse(d[:ed])
#     dates = {proj: i, }
#     @all_dates.push(dates)
#   end
#   @all_dates
# end
#
# @dates_to_compare = get_dates(@data)
# puts @dates_to_compare




@set_1_answer = []
@set_2_answer = []
@set_3_answer = []
@set_4_answer = []
