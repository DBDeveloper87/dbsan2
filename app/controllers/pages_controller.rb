class PagesController < ApplicationController
	layout "plain", only: :contenteditable

	def contenteditable
	end

	def game_board
		render layout: "game_board"
	end

	def bylaws
		@bylaws = Bylaw.first
	end

	def home
		@meta_title = "Home | DBSAN"
		@camps = Camp.all
	end

	def who_we_are
		@meta_title = "About Us | DBSAN"
		@sections = About.filter_by_published(true)
		@board = BoardMember.all
	end

	def video_layout
	end

	
end
