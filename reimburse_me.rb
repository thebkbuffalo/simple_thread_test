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

arg = ARGV[0]

def get_set(arg)
  case arg
  when "set_1"
    data = @sets.first
  when "set_2"
    data = @sets[1]
  when "set_3"
    data = @sets[2]
  when "set_4"
    data = @sets.last
  when nil
    data = @sets
  end
  data
end

@data = get_set(arg)
puts @data



def get_dates(data)
  if data.first.class == Array # for full data set
    data.each_with_index do |proj, i|
      binding.pry
      @dates_array = arrayify_dates(proj)
    end
  else # for individual data set
    @dates_array = arrayify_dates(data)
    @dates_array
  end
end

def arrayify_dates(set)
  @all_dates = []
  set.each_with_index do |d, i|
    sd = Date.parse(d[:sd])
    ed = Date.parse(d[:ed])
    dates = [sd, ed]
    @all_dates.push(dates)
  end
  @all_dates
end

get_dates(@data)




@set_1_answer = []
@set_2_answer = []
@set_3_answer = []
@set_4_answer = []
