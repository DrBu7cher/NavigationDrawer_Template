//
//  DrawerItemRow.swift
//  NavigationDrawer_Template
//
//  Created by GefaketHD on 10.11.19.
//  Copyright © 2019 GefaketHD. All rights reserved.
//

import SwiftUI

struct DrawerItemRow: View {
    var title:String
    var tag:Int
    @Binding var showingTab:Int
    @Binding var isOpen:Bool
    
    var body: some View {
        ZStack{
            if self.showingTab == tag {
                selectedTabColor
            }else{
                defaultTabColor
            }
            Text(title).foregroundColor((self.showingTab == tag ? .white : .black)).animation(.easeInOut(duration: drawerOpeningDuration))
        }.onTapGesture {
            withAnimation(.easeInOut(duration: drawerOpeningDuration)) {
                self.showingTab = self.tag
                self.isOpen = false
            }
        }
    }
}
