import SwiftUI

struct ShoppingListView: View {
    @EnvironmentObject var db: LocalDatabaseManager
    @State private var searchText = ""
    @State private var showClearAlert = false

    var groupedItems: [String: [ShoppingListItem]] {
        Dictionary(grouping: db.shoppingList.filter {
            searchText.isEmpty || $0.ingredient.localizedCaseInsensitiveContains(searchText)
        }) { $0.category ?? "Other" }
    }
    var checkedCount: Int { db.shoppingList.filter { $0.isChecked }.count }
    var progress: Double { db.shoppingList.isEmpty ? 0 : Double(checkedCount) / Double(db.shoppingList.count) }

    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemBackground).ignoresSafeArea()
                VStack(spacing: 0) {
                    // ── Header ─────────────────────────────────────────────
                    VStack(spacing: 0) {
                        HStack(alignment: .top) {
                            VStack(alignment: .leading, spacing: 3) {
                                Text("Shopping List")
                                    .font(.system(size: 32, weight: .bold, design: .rounded))
                                    .foregroundColor(.primary)
                                Text(db.shoppingList.isEmpty ? "No items" : "\(checkedCount) of \(db.shoppingList.count) items")
                                    .font(.system(size: 14)).foregroundColor(.secondary)
                            }
                            Spacer()
                            if !db.shoppingList.isEmpty {
                                Menu {
                                    Button("Clear All", role: .destructive) { showClearAlert = true }
                                } label: {
                                    Image(systemName: "ellipsis.circle")
                                        .font(.system(size: 22, weight: .medium))
                                        .foregroundColor(.secondary)
                                }
                            }
                        }
                        .padding(.horizontal, 20).padding(.top, 16).padding(.bottom, 12)

                        if !db.shoppingList.isEmpty {
                            // Progress bar
                            VStack(spacing: 6) {
                                GeometryReader { geo in
                                    ZStack(alignment: .leading) {
                                        RoundedRectangle(cornerRadius: 4).fill(Color(.systemGray5)).frame(height: 6)
                                        RoundedRectangle(cornerRadius: 4)
                                            .fill(LinearGradient(colors:[Color(red:0.20,green:0.78,blue:0.35),Color(red:0.15,green:0.68,blue:0.30)], startPoint:.leading, endPoint:.trailing))
                                            .frame(width: geo.size.width * progress, height: 6)
                                            .animation(.spring(response: 0.4, dampingFraction: 0.8), value: progress)
                                    }
                                }
                                .frame(height: 6)
                            }
                            .padding(.horizontal, 20).padding(.bottom, 12)

                            // Search bar
                            HStack(spacing: 10) {
                                Image(systemName: "magnifyingglass").font(.system(size: 15)).foregroundColor(.secondary)
                                TextField("Search items...", text: $searchText).textFieldStyle(.plain)
                                if !searchText.isEmpty {
                                    Button { searchText = "" } label: {
                                        Image(systemName: "xmark.circle.fill").foregroundColor(.secondary)
                                    }
                                }
                            }
                            .padding(.horizontal, 14).padding(.vertical, 11)
                            .background(Color(.systemGray6), in: RoundedRectangle(cornerRadius: 13))
                            .padding(.horizontal, 20).padding(.bottom, 12)
                        }
                        Divider()
                    }
                    .background(Color(.systemBackground))

                    // ── Content ────────────────────────────────────────────
                    if db.shoppingList.isEmpty {
                        VStack(spacing: 20) {
                            ZStack {
                                Circle().fill(Color(red:0.20,green:0.78,blue:0.35).opacity(0.08)).frame(width: 90, height: 90)
                                Image(systemName: "cart").font(.system(size: 38, weight: .light)).foregroundColor(Color(red:0.20,green:0.78,blue:0.35).opacity(0.5))
                            }
                            VStack(spacing: 8) {
                                Text("No Items Yet").font(.system(size: 18, weight: .semibold))
                                Text("Add ingredients from any recipe")
                                    .font(.system(size: 14)).foregroundColor(.secondary)
                            }
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    } else {
                        ScrollView(.vertical, showsIndicators: false) {
                            VStack(spacing: 20) {
                                ForEach(groupedItems.keys.sorted(), id: \.self) { category in
                                    VStack(alignment: .leading, spacing: 10) {
                                        HStack(spacing: 6) {
                                            Text(category)
                                                .font(.system(size: 14, weight: .bold))
                                                .foregroundColor(.secondary)
                                                .textCase(.uppercase)
                                                .tracking(0.5)
                                            Rectangle().fill(Color(.systemGray5)).frame(height: 1)
                                        }
                                        VStack(spacing: 8) {
                                            ForEach(groupedItems[category] ?? []) { item in
                                                ShoppingListItemRow(
                                                    item: item,
                                                    onToggle: { db.toggleShoppingItem(item.id) },
                                                    onDelete: { db.removeShoppingItem(item.id) }
                                                )
                                            }
                                        }
                                    }
                                }
                            }
                            .padding(.horizontal, 20).padding(.vertical, 16)
                        }
                    }
                }
            }
            .navigationBarHidden(true)
            .alert("Clear Shopping List", isPresented: $showClearAlert) {
                Button("Cancel", role: .cancel) {}
                Button("Clear All", role: .destructive) { db.clearShoppingList() }
            }
        }
    }
}

struct ShoppingListItemRow: View {
    let item: ShoppingListItem
    let onToggle: () -> Void
    let onDelete: () -> Void
    @State private var showDeleteConfirm = false

    var body: some View {
        HStack(spacing: 14) {
            Button(action: onToggle) {
                ZStack {
                    Circle().fill(item.isChecked ? Color(red:0.20,green:0.78,blue:0.35) : Color(.systemGray5))
                        .frame(width: 28, height: 28)
                    if item.isChecked {
                        Image(systemName: "checkmark").font(.system(size: 14, weight: .bold)).foregroundColor(.white)
                    }
                }
            }
            VStack(alignment: .leading, spacing: 3) {
                Text(item.ingredient)
                    .font(.system(size: 15, weight: .semibold)).foregroundColor(.primary)
                    .strikethrough(item.isChecked, color: Color(.systemGray3))
                Text("\(item.quantity) \(item.unit)")
                    .font(.system(size: 14)).foregroundColor(.secondary)
            }
            Spacer()
            Button { showDeleteConfirm = true } label: {
                Image(systemName: "xmark.circle.fill").font(.system(size: 18)).foregroundColor(Color(.systemGray3))
            }
            .alert("Remove Item?", isPresented: $showDeleteConfirm) {
                Button("Cancel", role: .cancel) {}
                Button("Remove", role: .destructive, action: onDelete)
            }
        }
        .padding(.horizontal, 14).padding(.vertical, 12)
        .background(
            RoundedRectangle(cornerRadius: 14)
                .fill(item.isChecked ? Color(red:0.20,green:0.78,blue:0.35).opacity(0.06) : Color(.systemBackground))
                .shadow(color: Color.black.opacity(item.isChecked ? 0 : 0.04), radius: 6, x: 0, y: 2)
        )
        .overlay(RoundedRectangle(cornerRadius: 14).strokeBorder(Color(.systemGray5).opacity(0.5), lineWidth: 0.5))
        .opacity(item.isChecked ? 0.72 : 1.0)
        .animation(.easeInOut(duration: 0.2), value: item.isChecked)
    }
}

#Preview { ShoppingListView().environmentObject(LocalDatabaseManager()) }
