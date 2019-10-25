import SwiftUI

struct AppTabView : View {
    var body : some View {
        TabView {
            //View public profiles of people your connected to
            landingView()
                .tabItem {
                    Image(systemName: "house")
            }
            //View public profiles of people your connected to
            dashboardView()
                .tabItem {
                    Image(systemName: "speedometer")
            }
            addPostView()
                .tabItem {
                    Image(systemName: "plus.circle")
            }
            
            ProfileView()
                .tabItem {
                    Image(systemName: "gear")
            }
            //View users private profile - should link to profiles page
            myPageView()
                .tabItem {
                    Image(systemName: "person")
            }
        }.background(Color("FHDusk"))
    }
}

struct landingView: View {
    
    @EnvironmentObject var session: SessionStore
    @State var profileIsEmpty = true

    func signOut() {
        session.signOut()
    }
    var body: some View {
        NavigationView {
            ZStack {
                Background(startColor: Color("FHBabyBlue"), endColor: Color("FHCoral"))
                VStack {
                    ZStack {
                        Image("OnboardingFive")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                        VStack {
                            
                            Text("somebody,\nwelcome to")
                                .font(.title)
                                .multilineTextAlignment(.center)
                                .foregroundColor(.gray)
                                .frame(width:300, height:100)
                            FHIconType(imageType: "gray")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width:100, height: 100)
                        }
                        .frame(width:300)
                    }
                    
                    Text("Get work down,\nget paid")
                        .font(.body)
                        .multilineTextAlignment(.center)
                        .frame(height:nil)
                        .lineLimit(2)
                        .foregroundColor(.white)
                    
                    HStack {
                        Button(action: signOut){
                            OutlineButton(buttonLabel: "Sign out")
                        }.padding(12)
                        
                        Button (action: {
                            print("Hey")
                        } ){
                            NavigationLink(destination: ProfileView()){
                                Text("Profile")
                            }
                        }
                    }
                }
            }
        }
    }
}

struct dashboardView : View {
    var body : some View {
        NavigationView {
            VStack{
                Text("Dashboard")
            }
        }
    }
}

struct addPostView : View {
    var body : some View {
        Text("Add post")
    }
}

struct tasksView : View {
    var body : some View {
        Text("Tasks page")
    }
}

struct myPageView : View {
    var body : some View {
        Text("My Page")
    }
}

struct AppView: View {
    var body: some View {
        NavigationView {
            AppTabView()
        }
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppTabView()
    }
}
