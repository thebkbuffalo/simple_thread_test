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
    @proj_breakdown = breakdown(@proj_dates, @proj_costs)
    @reimbursments_per_set = figure_costs(@proj_breakdown)
    puts 'Set ' + (i + 1).to_s
    i = []
    i.push('$' + @reimbursments_per_set.to_s + ' to be reimbursed')
    puts i
    puts @proj_dates
    puts @proj_costs
    puts '------------------------------------------------------------------------------------------------'
  end
end

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

def cost_breakdown(cost)
  if cost == 'low'
    @trip_costs = {travel: 45, full: 75}
  else
    @trip_costs = {travel: 55, full: 85}
  end
  @trip_costs
end

def figure_out_multiple_days(set)
  @set = set
  @proj_count = (1..@set.count).to_a
  @reimbursment_to_add_up = []
  @set.each_with_index do |proj, i|
    if proj[:days] == 0
      cost = cost_breakdown(proj[:cost])
      travel = cost[:travel]
      full = cost[:full]
      reimbursment = travel + full
      @reimbursment_to_add_up.push(reimbursment)
    else

    end
  end
  @reimbursment_to_add_up
end

def figure_costs(set)
  @set = set
  if @set.count == 1
    @single_proj_days_count = @set.first[:days]
    if @single_proj_days_count == 0
      cost = cost_breakdown(@set.first[:cost])
      travel = cost[:travel]
      full = cost[:full]
      @reimbursment = travel + full
    else
      # here would be logic for single project with multiple days...will fill this in when i figure it out
    end
  else
    @reimbursment = figure_out_multiple_days(@set).sum
    # @reimbursment = 'here will be totaled reimbursments'
  end
  @reimbursment
end


def breakdown(proj_dates, proj_costs)
  @days_per_set_with_cost = []
  proj_dates.each_with_index do |dates, i|
    cost_level = proj_costs[i]
    sd = dates.first
    ed = dates.last
    days_count = (ed - sd).to_i / 24
    @days_per_set_with_cost.push({cost: cost_level, days: days_count, sd: sd, ed: ed})
  end
  @days_per_set_with_cost
end

get_reimbursment_breakdown(@sets)
# @set_1_answer = []
# @set_2_answer = []
# @set_3_answer = []
# @set_4_answer = []


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
