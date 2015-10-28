package com.service;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import com.dao.MemberDao;
import com.dao.PlayDao;
import com.dao.TicketDao;
import com.pojo.Member;
import com.pojo.Play;
import com.pojo.Ticket;
import com.util.PageBean;
import com.util.SendHtmlMail;

public class TicketService {
	private TicketDao ticketDao=new TicketDao();

	public void setTicketDao(TicketDao ticketDao) {
		this.ticketDao = ticketDao;
	}
	
	private PlayDao playDao=new PlayDao();
	
	public void setPlayDao(PlayDao playDao) {
		this.playDao = playDao;
	}
	
	private MemberDao memberDao=new MemberDao();

	public void setMemberDao(MemberDao memberDao) {
		this.memberDao = memberDao;
	}

	/**
	 * Add Tickets
	 * @param member
	 * @param playId
	 * @param ticketPrice
	 * @param chooseSeatsNum
	 * @return
	 * @throws Exception 
	 */
	public void createTicket(Member member,Integer playId, Double ticketPrice, int[] chooseSeatsNum) throws Exception{	
		String toEmail="";
		String movieName="";
		Date time=new Date();
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy/MM/dd HH:mm");
		String seat="";
		Double money=0.;
		String ticketCode=member.getMemberEmail().substring(0, member.getMemberEmail().indexOf("@"))+"_"+System.nanoTime();
		for (int ticketSeat : chooseSeatsNum) {
			Play play=playDao.selectById(playId);
			Ticket ticket=new Ticket();
			ticket.setMember(member);
			ticket.setPlay(play);
			ticket.setTicketCode(ticketCode);
			ticket.setTicketDate(new Timestamp(new Date().getTime()));
			ticket.setTicketPrice(ticketPrice);
			ticket.setTicketSeat(ticketSeat);	
			ticket.setTicketFlag(true);
			ticketDao.insert(ticket);
			
			toEmail=ticket.getMember().getMemberEmail();
			movieName=ticket.getPlay().getMovie().getMovieName()+"("+ticket.getPlay().getMovie().getEdition().getEditionName()+")";
			time.setTime(ticket.getPlay().getPlayTime().getTime());
			seat+=ticket.getTicketSeat();
			money+=ticket.getTicketPrice();
			
			Double memberMoney=member.getMemberMoney()-ticket.getTicketPrice();
			if(memberMoney<0){
				System.out.println(1/0);
				throw new Exception("Not enough balance£¡Please reload balance£¡");
			}else{
				member.setMemberMoney(memberMoney);
				memberDao.update(member);
			}
		}
		
		String HtmlMsg="Dear "+(member.getMemberGender()?"Mr.":"Ms.")+member.getMemberName()+" Congratulation!Please keep this confirmation£¡<br/>"+"Order NO.: "+ticketCode+" Movie: "+movieName+" Schedule: "+sdf.format(time)+" "+seat+"Total: $"+money;
		new SendHtmlMail().sendHtmlMail(toEmail,HtmlMsg);
	}
	
	/**
	 * Paging for my order
	 * @param member
	 * @param currentPage
	 * @param pageSize
	 * @return
	 */
	public PageBean findByMemberByPage(Member member,int currentPage, int pageSize){
		return ticketDao.selectByMemberIdByPage(member.getMemberId(), currentPage, pageSize);
	}
	
	/**
	 * show today order
	 * @param member
	 * @return
	 */
	public List<Ticket> findTodayTicket(Member member){
		return ticketDao.selectTodayOrderByMemberId(member.getMemberId());
	}
	
	/**
	 * return tickets
	 * @param ticket
	 * @param member
	 */
	public void modifyReturn(Ticket ticket,Member member){
		Ticket oldTicket=ticketDao.selectById(ticket.getTicketId());
		oldTicket.setTicketFlag(false);
		ticketDao.update(oldTicket);
		
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy/MM/dd HH:mm");
		String toEmail=oldTicket.getMember().getMemberEmail();
		String HtmlMsg="Dear "+(member.getMemberGender()?"Mr.":"Ms.")+member.getMemberName()+" Congratulation! Your tickets is returned£¡Here is you return info£º<br/>"+"Order NO.: "+oldTicket.getTicketCode()+" Movie: "+oldTicket.getPlay().getMovie().getMovieName()+" Schedule: "+sdf.format(oldTicket.getPlay().getPlayTime())+" "+oldTicket.getTicketSeat();
		new SendHtmlMail().sendHtmlMail(toEmail,HtmlMsg);
		
		Member oldMember=memberDao.selectById(member.getMemberId());
		oldMember.setMemberMoney(member.getMemberMoney()+oldTicket.getTicketPrice());
		memberDao.update(oldMember);
	}
	
	/**
	 * Search tickets
	 * @param ticket
	 */
	public List<Ticket> findTickets(Ticket ticket){
		return ticketDao.selectByCode(ticket.getTicketCode());
	}
	
	/**
	 * search tickets(return)
	 * @param ticket
	 */
	public List<Ticket> findReturnTickets(Ticket ticket){
		return ticketDao.selectReturnByCode(ticket.getTicketCode());
	}
}
