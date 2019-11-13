//
//  ContentView.swift
//  NavigationDrawer_Template
//
//  Created by GefaketHD on 10.11.19.
//  Copyright © 2019 GefaketHD. All rights reserved.
//

import SwiftUI
import UIKit

let drawerOpeningDuration:Double = 0.6

let defaultBackgroundColor:Color = .blue

let navBarBackgroundColor:Color = .green

let drawerBackgroundColor:Color = .gray

let blurBorderColor:Color = .orange//Bei BLUR-Effekt die Umrandung des verschwommenen Hintergrunds

let selectedTabColor:Color = .yellow
let defaultTabColor:Color = .red

struct ContentView: View {
    @State var showingTab:Int = 0
    @State var isDrawerOpen:Bool = false
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    private var screen: CGRect { UIScreen.main.bounds}
    
    var body: some View {
        ZStack{
            Color.orange.edgesIgnoringSafeArea(.all)

            VStack(spacing: 0){
                HStack{
                    Button(action: {
                        withAnimation(.easeInOut(duration: drawerOpeningDuration)){
                            self.isDrawerOpen.toggle()
                        }
                    }){Image(systemName: "list.dash").foregroundColor(.black).padding(.leading, 16).padding(.vertical, 18).scaleEffect(1.5)}
                    Spacer()
                    }.background(navBarBackgroundColor.edgesIgnoringSafeArea(.top))
//                Spacer()
                TabView(selection: self.$showingTab){
                    HomeView().tag(0)
                    TaskListView().tag(1)
                    SwitchingView().tag(2)
                    GroupView().tag(3)
                    SettingsView().tag(4)
                    AboutView().tag(5)
                }.blur(radius: (self.isDrawerOpen ? 10 : 0))
            }
            if self.isDrawerOpen {
                TransparentView().onTapGesture {
                    if self.isDrawerOpen {
                        withAnimation(.easeInOut(duration: drawerOpeningDuration)){
                            self.isDrawerOpen = false
                        }
                    }
                }
            }
            
            NavigationDrawer(isOpen: self.$isDrawerOpen, tab: self.$showingTab).offset(x: self.isDrawerOpen ? 0 : -screen.width)
        }
    }
}

struct DrawerContent: View {
    @Binding var tab:Int
    @Binding var isOpen:Bool
    
    init(tab: Binding<Int>, isOpen:Binding<Bool>) {
        self._tab = tab
        self._isOpen = isOpen
        
        UITableView.appearance().tableFooterView = UIView()
        UITableView.appearance().separatorStyle = .none
        UITableView.appearance().backgroundColor = .none
        UITableView.appearance().alwaysBounceVertical = false
        UITableView.appearance().allowsSelection = false
        UITableViewCell.appearance().backgroundColor = .none
    }
    
    var body: some View {
        VStack{
            VStack(alignment: .leading){
                Image("icon").resizable().frame(width: 130, height: 130)
                Text("Example-Text").font(Font.custom("AvenirNext-Bold", size: 20)).foregroundColor(.white)
                Text("example@example.com").font(Font.custom("AvenirNext-Regular", size: 17)).foregroundColor(.white)
            }.frame(minWidth: 0, maxWidth: .infinity, alignment: .leading).padding(.leading, 16).padding(.top, 16)
            List{
                DrawerItemRow(title: "Home", tag: 0, showingTab: self.$tab, isOpen: self.$isOpen)
                DrawerItemRow(title: "TaskList", tag: 1, showingTab: self.$tab, isOpen: self.$isOpen)
                DrawerItemRow(title: "Switching", tag: 2, showingTab: self.$tab, isOpen: self.$isOpen)
                DrawerItemRow(title: "Group", tag: 3, showingTab: self.$tab, isOpen: self.$isOpen)
                DrawerItemRow(title: "Settings", tag: 4, showingTab: self.$tab, isOpen: self.$isOpen)
                DrawerItemRow(title: "About", tag: 5, showingTab: self.$tab, isOpen: self.$isOpen)
            }.listRowInsets(.none)
        }
    }
}

struct NavigationDrawer: View {
    private let width = UIScreen.main.bounds.width - 100
    @Binding var isOpen: Bool
    @Binding var tab: Int
    
    var body: some View {
        HStack {
            ZStack{
                defaultBackgroundColor.edgesIgnoringSafeArea(.vertical)
                DrawerContent(tab: self.$tab, isOpen: self.$isOpen)
                    .animation(.easeInOut(duration: drawerOpeningDuration)).edgesIgnoringSafeArea(.bottom)
            }.background(drawerBackgroundColor).frame(width: self.width)
            .offset(x: self.isOpen ? 0 : -self.width)
            Spacer()
        }
    }
}

struct TransparentView: UIViewControllerRepresentable {
    typealias UIViewControllerType = UIViewController


    func makeUIViewController(context: UIViewControllerRepresentableContext<TransparentView>) -> TransparentView.UIViewControllerType {
        let vc = UIViewController()
        vc.view.backgroundColor = .none
        return vc
    }

    func updateUIViewController(_ uiViewController: TransparentView.UIViewControllerType, context: UIViewControllerRepresentableContext<TransparentView>) {
        //
    }
}
