use eframe::{Result, egui, run_native};
fn main() -> Result {
    let native_options = eframe::NativeOptions::default();
    let app_creator: eframe::AppCreator<'_> = Box::new(|cc| Ok(Box::new(App::new(cc))));
    run_native("native demo", native_options, app_creator)
}

#[derive(Default)]
struct App {
    label: String,
    value: f32,
}

impl App {
    fn new(_: &eframe::CreationContext<'_>) -> Self {
        Self {
            label: "None!".to_owned(),
            value: 2.7,
        }
    }
}

impl eframe::App for App {
    fn update(&mut self, ctx: &egui::Context, _frame: &mut eframe::Frame) {
        egui::CentralPanel::default().show(ctx, |ui| {
            ui.heading("egui app");
            ui.horizontal(|ui| {
                ui.label("Write something: ");
                ui.text_edit_singleline(&mut self.label);
            });
            ui.separator();
            ui.add(egui::Slider::new(&mut self.value, 0.0..=10.0).text("value"));
            if ui.button("Increment").clicked() {
                self.value = self.value.max(self.value + 1.0).min(10.0);
            }
        });
    }
}
