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

# set = ARGV[0]
#
# def get_set(set)
#   case set
#   when set == 'set_1'
#     @set_1
#   when set == 'set_2'
#     @set_2
#   when set == 'set_3'
#     @set_3
#   when set == 'set_4'
#     @set_4
# end


def get_dates(@sets)
  binding.pry
end

set_1_answer = []
set_2_answer = []
set_3_answer = []
set_4_answer = []
