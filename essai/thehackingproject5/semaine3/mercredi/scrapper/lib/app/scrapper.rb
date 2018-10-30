require 'nokogiri'
require 'json'
require 'open-uri'
require "google_drive"



class Scrapper
  attr_reader :email_hash

  def initialize(department_url)
    @department_url = department_url
    @townhall_urls_hash = Hash.new
    self.get_all_the_urls_of_val_doise_townhalls
    @email_hash = Hash.new
    self.get_all_the_emails_of_val_doise_townhalls
  end

  def get_the_email_of_a_townhall_from_its_webpage(townhall_url)
    page = Nokogiri::HTML(open(townhall_url))
    email = page.xpath('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]').text
    puts email
    return email
  end

  def get_all_the_urls_of_val_doise_townhalls
    page = Nokogiri::HTML(open(@department_url))
    a_elements = page.xpath('//a')

    a_elements.each do |a_element|
      link = a_element['href']
      if link.include?('./95/')
        link[0] = "http://annuaire-des-mairies.com"
        @townhall_urls_hash[a_element.text] = link #mon hash final récupère en clé le nom de la ville (a_element.text) et en valeur l'url (link)
      end
    end
  end

  def get_all_the_emails_of_val_doise_townhalls
    @townhall_urls_hash.each do |townhall_name, townhall_url|
      @email_hash[townhall_name] = get_the_email_of_a_townhall_from_its_webpage(townhall_url)
    end
  end

  def google_drive_writer
    session = GoogleDrive::Session.from_config("config.json")
    ws = session.spreadsheet_by_key("1K_XxcSTdHA-mY8uiUqj2p6DXo3Q7vlP-z3md3WhmXOw").worksheets[0]
    #spreadsheet = session.create_spreadsheet(title = "Emails du val d'Oise") (POUR CREER UNE NOUVELLE SPREADSHEET)
    spreadsheet = session.spreadsheet_by_title(title = "essai")

    ws = spreadsheet.worksheets[0]
    ws[1,1] = "Nom des villes"
    ws[1,2] = "Emails"
    row = 1
    @email_hash.each do |townhall_name, townhall_email|
      row += 1
      ws[row,1] = townhall_name
      ws[row,2] = townhall_email
      ws.save

    end
    ws.save
    ws.reload 
  end

  def perform
    puts @email_hash
    puts
    puts "*** Export GDrive lancé ***"
    self.google_drive_writer
    puts "*** Export GDrive fini ***"
  end
end

