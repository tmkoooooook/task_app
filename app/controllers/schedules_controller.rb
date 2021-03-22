class SchedulesController < ApplicationController
    def index
        @schedules = Schedule.all
        @record_count = "スケジュール合計：#{Schedule.count}"
    end
    
    def new
        @schedule = Schedule.new
    end
    
    def create
        @schedule = Schedule.new(params.require(:schedule).permit(:title, :start_day, :end_day, :all_day, :memo))
        if @schedule.save
            flash[:notice] = "スケジュールを登録しました"
            redirect_to :schedules
        else
            flash[:notice] = "登録できませんでした"
            render "new"
        end
    end
    
    def show
        
        @schedule = Schedule.find(params[:id])
    end
    
    def edit
        @schedule = Schedule.find(params[:id])
    end
    
    def update
        @schedule = Schedule.find(params[:id])
        if @schedule.update(params.require(:schedule).permit(:title, :start_day, :end_day, :all_day, :memo))
            flash[:notice] = "ID#{@schedule.id}のスケジュールの更新をしました"
            redirect_to :schedules
        else
            flash[:notice] = "編集できませんでした"
            render "edit"
        end
    end
    
    def destroy
        @schedule = Schedule.find(params[:id])
        @schedule.destroy
        flash[:notice] = "スケジュールを削除しました"
        redirect_to :schedules
    end
    
    def search
        selection = params[:schedule][:keyword]
        
        @schedules = Schedule.sort(selection)
    end
end
