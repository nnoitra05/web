class BoardsController < ApplicationController
  
  def new
    @board = Board.new
  end

  def create
    @board = Board.new(board_params)
    if @board.save
      redirect_to root_path
    else
      render "/board/new"
    end
  end

  def destroy
    board = Board.find(params[:id])
    board.destroy
    redirect_to root_path
  end

  private

  def board_params
    params.require(:board).permit(:name, :path, :image).merge(user_id: current_user.id)
  end

end
