//  CreateProfile.swift
//  FHCreative
//
//  Created by Admin on 23/10/2019.
//  Copyright © 2019 MontiRed. All rights reserved.

import SwiftUI

struct createProfileView : View {
    
    @EnvironmentObject var session : SessionStore
    
    @State var firstname : String = ""
    @State var lastname : String = ""
    @State var cellphone : String = ""
    @State var dateOfBirth = Date()
    @State var dob : Double = 0
    @State var town : String = ""
    @State var country : String = ""
    @State var ratePerHour : Double = 0
    @State var userType : String = "user"
    @State var company : String = " "
    @State var rating : Int = 0
    
    func createProfile() {
        dob = convertDateToDouble(getDate: dateOfBirth)
        let params : [String:Any] = ["firstname" : firstname, "lastname" : lastname, "cellphone" : cellphone, "dateOfBirth" : dob, "town" : town, "country" : country, "ratePerHour" : ratePerHour, "company" : company, "userType" : userType, "rating": rating ]
        session.addData(userParams: params, collectionReference: "users", documentReference: session.session?.uid ?? "")
    }
    
    func updateFields(){
        //Input the profile information into the fields
        firstname = session.profile?.firstname ?? ""
        lastname = session.profile?.lastname ?? ""
        cellphone = session.profile?.cellphone ?? ""
        dob = session.profile?.dateOfBirth ?? 0
        town = session.profile?.town ?? ""
        country = session.profile?.country ?? ""
        ratePerHour = session.profile?.ratePerHour ?? 0
        company = session.profile?.company ?? ""
        rating = session.profile?.rating ?? 0
        userType = session.profile?.userType ?? ""
        dateOfBirth = convertDoubleToDate(dateAsDouble: dob)
    }
    
    var body: some View {
        
        ZStack {
            Background(startColor: Color("FHDusk"), endColor: Color("FHCoral"))
            ScrollView {
                VStack {
                    
                    VStack {
                        //Profile image icon
                        Text("Profile picture and Username are visible to the public. Name, Cell, DOB and address are private and are used when processing payment").font(.caption).foregroundColor(.white).frame(height: 45)
                    }
                    VStack {
                        CustomTextField(systemImageName: "person", textLabel: "firstname", inputText: $firstname)
                        CustomTextField(systemImageName: "person", textLabel: "lastname", inputText: $lastname)
                        CustomTextField(systemImageName: "phone", textLabel: "cellphone", inputText: $cellphone)
                        CustomTextField(systemImageName: "pin", textLabel: "town", inputText: $town)
                        CustomTextField(systemImageName: "map", textLabel: "country", inputText: $country)
                        Text("Date of birth").foregroundColor(.white)
                        DatePicker(
                            selection: $dateOfBirth,
                            //in: dateClosedRange,
                            displayedComponents: .date,
                            label: { Text("") }
                        ).foregroundColor(.white)
                        
                        //Text("Date of birth: \(formatDate(date: dateOfBirth))").foregroundColor(.white)
                        VStack {
                            Slider(value: $ratePerHour, in: 500...10000, step: 100)
                            Text("Rate per hour: \(doubleToString(getDouble: ratePerHour))")
                        }
                        Button(action:{
                            self.createProfile()
                        }){
                            OutlineButton(buttonLabel: "Save").padding(24)
                        }
                    }.onAppear(perform: updateFields).frame(width:340)
                }
            }
        }
    }
}

struct teamView : View {
    
    @State var companyName : String = ""
    @State var companyTel : String = ""
    @State var companyEmail : String = ""
    @State var companyTown : String = ""
    @State var companyCountry : String = ""
    @State var designation : String = ""
    
    var body: some View {
        ScrollView {
            ZStack {
                Background(startColor: Color("FHDusk"), endColor: Color("FHCoral"))
                VStack {
                    //Profile image icon
                    Image("CompanyLogo").resizable().aspectRatio(contentMode: .fill).frame(width: 120, height: 120).padding(24)
                    //Text fields
                    CustomTextField(systemImageName: "flag", textLabel: "company name", inputText: $companyName)
                    CustomTextField(systemImageName: "flag", textLabel: "my designation", inputText: $designation)
                    CustomTextField(systemImageName: "person", textLabel: "company tel no.", inputText: $companyTel)
                    CustomTextField(systemImageName: "phone", textLabel: "work email", inputText: $companyEmail)
                    CustomTextField(systemImageName: "pin", textLabel: "town", inputText: $companyTown)
                    CustomTextField(systemImageName: "map", textLabel: "country", inputText: $companyCountry)
                    
                    Button(action: {}){
                        OutlineButton(buttonLabel: "Next").padding(24)
                    }
                }.frame(width: 340)
            }
        }
    }
}

struct industryView : View {
    @State var companyName : String = ""
    @State var companyTel : String = ""
    @State var companyEmail : String = ""
    @State var companyTown : String = ""
    @State var companyCountry : String = ""
    var body: some View {
        ScrollView {
            ZStack {
                Background(startColor: Color("FHDusk"), endColor: Color("FHCoral"))
                VStack {
                    //Profile image icon
                    Image("CompanyLogo").resizable().aspectRatio(contentMode: .fill).frame(width: 120, height: 120).padding(24)
                    //Text fields
                    CustomTextField(systemImageName: "flag", textLabel: "company name", inputText: $companyName)
                    CustomTextField(systemImageName: "person", textLabel: "company tel no.", inputText: $companyTel)
                    CustomTextField(systemImageName: "phone", textLabel: "work email", inputText: $companyEmail)
                    CustomTextField(systemImageName: "pin", textLabel: "town", inputText: $companyTown)
                    CustomTextField(systemImageName: "map", textLabel: "country", inputText: $companyCountry)
                    Button(action: {}){
                        OutlineButton(buttonLabel: "Next").padding(24)
                    }
                }.frame(width: 340)
            }
        }
    }
}

struct skillsView : View {
    @State var companyName : String = ""
    @State var companyTel : String = ""
    @State var companyEmail : String = ""
    @State var companyTown : String = ""
    @State var companyCountry : String = ""
    var body: some View {
        ScrollView {
            ZStack {
                Background(startColor: Color("FHDusk"), endColor: Color("FHCoral"))
                VStack {
                    //Profile image icon
                    Image("CompanyLogo").resizable().aspectRatio(contentMode: .fill).frame(width: 120, height: 120).padding(24)
                    //Text fields
                    CustomTextField(systemImageName: "flag", textLabel: "company name", inputText: $companyName)
                    CustomTextField(systemImageName: "person", textLabel: "tel no.", inputText: $companyTel)
                    CustomTextField(systemImageName: "phone", textLabel: "work email", inputText: $companyEmail)
                    CustomTextField(systemImageName: "pin", textLabel: "town", inputText: $companyTown)
                    CustomTextField(systemImageName: "map", textLabel: "country", inputText: $companyCountry)
                    Button(action: {}){
                        OutlineButton(buttonLabel: "Next").padding(24)
                    }
                }.frame(width: 340)
            }
        }
    }
}

struct settingsView : View {
    @State var companyName : String = ""
    @State var companyTel : String = ""
    @State var companyEmail : String = ""
    @State var companyTown : String = ""
    @State var companyCountry : String = ""
    var body: some View {
        ScrollView {
            ZStack {
                Background(startColor: Color("FHDusk"), endColor: Color("FHCoral"))
                VStack {
                    //Profile image icon
                    Image("CompanyLogo").resizable().aspectRatio(contentMode: .fill).frame(width: 120, height: 120).padding(24)
                    //Text fields
                    CustomTextField(systemImageName: "flag", textLabel: "company name", inputText: $companyName)
                    CustomTextField(systemImageName: "person", textLabel: "tel no.", inputText: $companyTel)
                    CustomTextField(systemImageName: "phone", textLabel: "work email", inputText: $companyEmail)
                    CustomTextField(systemImageName: "pin", textLabel: "town", inputText: $companyTown)
                    CustomTextField(systemImageName: "map", textLabel: "country", inputText: $companyCountry)
                    Button(action: {}){
                        OutlineButton(buttonLabel: "Next").padding(24)
                    }
                }.frame(width: 340)
            }
        }
    }
}

struct ProfileView: View {
    var body: some View {
            createProfileView()
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
