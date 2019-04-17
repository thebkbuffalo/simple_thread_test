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
    @reimbursments_per_set = figure_costs(@proj_breakdown, @proj_dates)
    puts 'Set ' + (i + 1).to_s
    i = []
    i.push('$' + @reimbursments_per_set.to_s + ' to be reimbursed')
    puts i
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

def full_days_breakdown(full_days, ol_or_dp)
  if full_days == 0
    full_days = full_days + 1
  else
    full_days = full_days - ol_or_dp
  end
  @full_days = full_days
end

def get_travel_and_full_days(proj_dates, set)
  @proj_dates = proj_dates
  @travel_days_before_calculation = []
  @travel_days_after_calculation = []
  @full_days_before_calculation = []
  @full_days_after_calculation = []
  x = 0
  until x == @proj_dates.count
    @cost = cost_breakdown(set[x][:cost])
    if x == 0 # first project
      @travel_days_before_calculation.push(1)
    end
    unless x.equal? @proj_dates.count - 1
      if @proj_dates[x]&.last == @proj_dates[x+1]&.first # overlapping travel days "ol"
        @travel_days_before_calculation.push(1)
        full_days = (@proj_dates[x]&.last - @proj_dates[x]&.first).to_i / 24
        @full_days = full_days_breakdown(full_days, 1)
        @full_days_before_calculation.push(full_days)
      else # days btwn travel days "dp"
        btwn_days = (@proj_dates[x+1].first - @proj_dates[x].last).to_i / 24
        @travel_days_before_calculation.push(btwn_days)
        full_days = (@proj_dates[x]&.last - @proj_dates[x]&.first).to_i / 24
        @full_days = full_days_breakdown(full_days, 2)
        @full_days_before_calculation.push(full_days)
      end
    else # last project
      if @proj_dates[x]&.first == @proj_dates[x-1]&.last
        @travel_days_before_calculation.push(1)
        full_days = (@proj_dates[x]&.last - @proj_dates[x]&.first).to_i / 24
        @full_days = full_days_breakdown(full_days, 1)
        @full_days_before_calculation.push(full_days)
      else
        @travel_days_before_calculation.push(2)
        full_days = (@proj_dates[x]&.last - @proj_dates[x]&.first).to_i / 24
        @full_days = full_days_breakdown(full_days, 2)
        @full_days_before_calculation.push(full_days)
      end
    end
    tday_calc = @travel_days_before_calculation.sum * @cost[:travel]
    @travel_days_after_calculation.push(tday_calc)
    fday_calc = @full_days_before_calculation.sum * @cost[:full]
    @full_days_after_calculation.push(fday_calc)
    x += 1
  end
  @breakdown = {travel_days: @travel_days_after_calculation, full_days: @full_days_after_calculation}
  @breakdown
end

def figure_costs(set, proj_dates)
  @set = set
  @proj_dates = proj_dates

  if @set.count == 1 #single day proj
    @single_proj_days_count = @set.first[:days]
    if @single_proj_days_count == 0
      cost = cost_breakdown(@set.first[:cost])
      travel = cost[:travel]
      full = cost[:full]
      @reimbursment = travel + full
    else
      if proj[:days] <= 3
        proj[:days] = proj[:days] + 1
      end
      full_days = days.tap{|x| x.pop; x.shift}
      travel_days_cost = @travel * 2
      full_days_cost = full_days.count * @full
      reimbursment = travel_days_cost + full_days_cost
      @reimbursment.push(reimbursment).sum
    end
  else # multi day proj
    to_add_up = get_travel_and_full_days(@proj_dates, @set)
    @reimbursment = to_add_up[:travel_days].sum + to_add_up[:full_days].sum
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
