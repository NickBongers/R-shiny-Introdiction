from shiny import App, reactive, render, ui

app_ui = ui.page_fluid(
    ui.input_select("condition", "Select input", {"hide": "Hide", "show": "Show"}),
    ui.panel_conditional(
        "input.condition === 'show'",
        ui.input_slider("weight", "Weight in kg", 0, 150, 80),
        ui.input_slider("height", "Height in cm", 0, 220, 180),
        ui.input_action_button("compute", "Start"),
        ui.output_text_verbatim("txt"),),
    ui.panel_conditional(
        "input.condition === 'hide'",
        )
    )


def server(input, output, session):
    @output
    @render.text
    @reactive.event(input.compute)
    def txt():
        bmi = input.weight() / (input.height()/100 * input.height()/100)
        return f" BMI is {bmi}"


app = App(app_ui, server)
