require "active_record"

module Todo

  class Task < ActiveRecord::Base
    scope :status_is,->(status){ where(status:status)}
    NOT_YET=0
    DONE=1
    PENDING=2

    STATUS={
      'NOTYET'=>NOT_YET,
      'DONE'=>DONE,
      'PENDING'=>PENDING
    }.freeze

    validates :name,presence:true,length:{maximum:140}
    validates :content,presence:true
    validates :status,numericality:true,inclusion:{in:STATUS.values}
  end

end
