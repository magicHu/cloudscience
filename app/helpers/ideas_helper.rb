# coding: utf-8  
module IdeasHelper
  def get_state(state)
    if state == 0
      '已提出'
    elsif state == 1
      '正在处理'
    elsif state == 2
      '已处理'
    end
  end
  
  def can_modify(idea)
    if idea.state == 0
      true
    else
      false
    end
  end
end
