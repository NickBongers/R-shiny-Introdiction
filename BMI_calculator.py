from shiny import App, render, ui

app_ui = ui.page_fluid(
    ui.input_slider("weight", "Weight in kg", 0, 150, 80),
    ui.input_slider("height", "Height in cm", 0, 220, 180),
    ui.output_text_verbatim("txt"),
)


def server(input, output, session):
    @output
    @render.text
    def txt():
        bmi = input.weight() / (input.height()/100 * input.height()/100)
        return f" BMI is {bmi}"


app = App(app_ui, server)
